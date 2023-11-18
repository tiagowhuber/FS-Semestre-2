import 'package:flutter/material.dart';
import 'package:frontend_app/utils/colors.dart';
import 'models/camara.dart';

class Camaras extends StatefulWidget {
  const Camaras({Key? key}) : super(key: key);

  @override
  CamarasState createState() => CamarasState();
}

class CamarasState extends State<Camaras> {
  List<Camara> camaras = [
    Camara(
      nombre: 'Cámara del estacionamiento N.º 1 Pinacoteca',
      ubicacion: 'Lorenzo Arenas 123456',
    ),
    Camara(
      nombre: 'Cámara del estacionamiento N.º 2 Pinacoteca',
      ubicacion: 'Lorenzo Arenas 123457',
    ),
    Camara(
      nombre: 'Cámara del estacionamiento Biblioteca Central',
      ubicacion: 'Lorenzo Arenas 987654',
    ),
    Camara(
      nombre: 'Cámara de la Facultad de Ingeniería',
      ubicacion: 'Lorenzo Arenas 1313',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: naranjaUdec,
        title: const Text('Cámaras', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _mostrarDialogoAgregarCamara(context);
            },
          ),
        ],
      ),
      backgroundColor: azulUdec,
      body: ListView.builder(
        itemCount: camaras.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              camaras[index].nombre,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              camaras[index].ubicacion,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                _eliminarCamara(index);
              },
            ),
          );
        },
      ),
    );
  }

  void _mostrarDialogoAgregarCamara(BuildContext context) {
    String nombre = '';
    String ubicacion = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: azulUdec,
          title: const Text(
            'Agregar Cámara',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    nombre = value;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    ubicacion = value;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Ubicación',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  camaras.add(Camara(nombre: nombre, ubicacion: ubicacion));
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Agregar',
                style: TextStyle(color: naranjaUdec),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: naranjaUdec),
              ),
            ),
          ],
        );
      },
    );
  }

  void _eliminarCamara(int index) {
    setState(() {
      camaras.removeAt(index);
    });
  }
}
