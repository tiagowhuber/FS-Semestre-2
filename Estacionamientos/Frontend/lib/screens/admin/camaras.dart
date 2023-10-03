import 'package:flutter/material.dart';
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
        title: const Text('Cámaras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _mostrarDialogoAgregarCamara(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: camaras.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(camaras[index].nombre),
            subtitle: Text(camaras[index].ubicacion),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
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
          title: const Text('Agregar Cámara'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    nombre = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    ubicacion = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Ubicación',
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
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
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
