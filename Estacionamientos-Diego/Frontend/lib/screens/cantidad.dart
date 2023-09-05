import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend_app/screens/menu_estacionamientos.dart';
import 'package:frontend_app/utils/colors.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cantidad extends StatefulWidget {
  const Cantidad({Key? key, required this.nombre, required this.ubicacion})
      : super(key: key);
  final String nombre;
  final String ubicacion;

  @override
  State<Cantidad> createState() => _CantidadState();
}

class _CantidadState extends State<Cantidad> {
  int cantidad = 0;
  late DateTime fechaActual;
  late String horaActual;
  late String fechaFormateada;

  @override
  void initState() {
    super.initState();
    _fetchData();
    obtenerFechaHoraActual();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/parking'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty) {
          final espacios = jsonResponse['available_spaces'];

          setState(() {
            cantidad = espacios;
          });
        } else {
          print('La respuesta JSON no es una lista o está vacía');
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> obtenerFechaHoraActual() async {
    fechaActual = DateTime.now();
    horaActual = DateFormat.Hm().format(fechaActual);
    fechaFormateada = DateFormat.yMd().format(fechaActual);
  }

  Future<void> _refreshData() async {
    await _fetchData();
    // Aquí puedes realizar cualquier tarea de recarga de datos
    // Por ejemplo, puedes llamar a una API para obtener datos actualizados
    // o reiniciar valores en tu estado interno

    // Espera simulada de 2 segundos (puedes eliminar esto en tu implementación)
    // Random random = Random();
    // int nuevoNumero = random.nextInt(34) + 1;
    // Después de completar la tarea de recarga, llama a setState para reconstruir la vista
    setState(() {
      // cantidad=nuevoNumero;
      obtenerFechaHoraActual();
      // Actualiza el estado necesario
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: azulUdec,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.nombre,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    color: const Color(0xffffffff),
                  ),
                ),
                Text(
                  widget.ubicacion,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    color: const Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: screenHeight / 6,
        backgroundColor: naranjaUdec,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(screenWidth, 40.0),
          ),
        ),
        elevation: 10.0,
        shadowColor: negroUdec,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Container(
                  // margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  padding: const EdgeInsets.only(
                      bottom: 20.0, right: 0.0, left: 0.0, top: 24.0),
                  child: Text(
                    'HAY',
                    style: GoogleFonts.lato(
                      fontSize: screenHeight / 22,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    bottom: 10.0, right: 0.0, left: 0.0, top: 10.0),
                width: double.infinity,
                height: screenHeight / 3,
                decoration: BoxDecoration(
                  color: getColorCantidad(cantidad),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cantidad.toString(),
                      style: GoogleFonts.inter(
                        fontSize: screenHeight / 8,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    bottom: 10.0, right: 0.0, left: 0.0, top: 10.0),
                constraints: const BoxConstraints(
                  maxWidth: 254,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ESPACIOS\nDISPONIBLES',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: screenHeight / 16,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                constraints: const BoxConstraints(
                  maxWidth: 254,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Última actualización:',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 2, 10, 20),
                  constraints: const BoxConstraints(
                    maxWidth: 254,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.access_time,
                              color: Color(0xffffffff)),
                          const SizedBox(width: 10),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              horaActual,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.calendar_month_outlined,
                              color: Color(0xffffffff)),
                          const SizedBox(width: 10),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              fechaFormateada,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: screenHeight / 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: naranjaUdec,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10)),
                      child: const Icon(
                        Icons.home,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Color getColorCantidad(int cantidad) {
  if (cantidad >= 0 && cantidad <= 10) {
    return rojoIntenso;
  } else if (cantidad >= 11 && cantidad <= 20) {
    return amarilloIntenso;
  } else if (cantidad > 21) {
    return verdeOscuro;
  } else if (cantidad == -1) {
    return Colors.grey;
  } else {
    throw ArgumentError('Cantidad inválida');
  }
}
