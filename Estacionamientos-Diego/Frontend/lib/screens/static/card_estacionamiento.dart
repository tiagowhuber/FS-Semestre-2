import 'package:flutter/material.dart';
import 'package:frontend_app/screens/cantidad.dart';
import 'package:frontend_app/utils/colors.dart';

class CardEstacion extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String disponibilidad;
  final bool favorito;
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;

  CardEstacion({
    required this.nombre,
    required this.ubicacion,
    required this.disponibilidad,
    required this.favorito,
    this.backgroundColor = Colors.white,
    this.titleStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      color: Colors.white,
    ),
    this.descriptionStyle = const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight/4.8,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: amarilloUdec,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: screenWidth,
                    // height: (screenHeight/4.8)/2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cantidad(nombre:nombre,ubicacion: ubicacion)),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        child: Image.asset(
                          getImagenByDisponibilidad(disponibilidad),
                          fit: BoxFit.cover,
                          ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0, left: 8.0,top: 8.0),
                            child: Icon(
                              Icons.circle,
                              color:getColorByDisponibilidad(disponibilidad),
                              size: 36),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 0.0, right: 8.0, left: 8.0,top: 8.0),
                            child: favorito 
                              ? const Icon(
                                  Icons.star,
                                  color: amarilloIntenso,
                                  size: 40)
                              : const Icon(
                                  Icons.star_border,
                                  color: Colors.white,
                                  size: 40,
                                ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
              padding: const EdgeInsets.only(bottom: 0.0, right: 0.0, left: 20.0,top: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.car_crash),
                        const SizedBox(width: 10),
                        Text(
                          nombre,
                          style: titleStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 10),
                        Text(
                          ubicacion,
                          style: descriptionStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color getColorByDisponibilidad(String disponibilidad) {
  switch (disponibilidad) {
    case 'bajo':
      return verdeOscuro;
    case 'medio':
      return amarilloIntenso;
    case 'lleno':
      return rojoIntenso;
    default:
      return Colors.grey;
  }
}

String getImagenByDisponibilidad(String disponibilidad) {
  switch (disponibilidad) {
    case 'lleno':
      return "assets/images/lleno.jpg";
    case 'medio':
      return "assets/images/medio.jpg";
    case 'bajo':
      return "assets/images/vacio.jpg";
    default:
      return "assets/images/nodisponible.jpg";
  }
}