import 'package:flutter/material.dart';
import 'package:frontend_app/screens/static/card_estacionamiento.dart';
import 'package:frontend_app/utils/colors.dart';

class MenuEstacionamientos extends StatefulWidget {
  const MenuEstacionamientos({super.key});

  @override
  State<MenuEstacionamientos> createState() => _MenuEstacionamientosState();
}

class _MenuEstacionamientosState extends State<MenuEstacionamientos> {
  final List<CardEstacion> cards = [
    CardEstacion(nombre:'Estacionamiento N.º 1 Pinacoteca',ubicacion:'Lorenzo Arenas 123456',disponibilidad:'bajo',favorito: true),
    CardEstacion(nombre:'Estacionamiento N.º 2 Pinacoteca',ubicacion:'Lorenzo Arenas 123457',disponibilidad:'lleno',favorito: false),
    CardEstacion(nombre:'Estacionamiento Biblioteca Central',ubicacion:'Lorenzo Arenas 987654',disponibilidad:'no disponible',favorito: true),
    CardEstacion(nombre:'Facultad de Ingenieria',ubicacion:'Lorenzo Arenas 1313',disponibilidad:'medio',favorito: false),
    CardEstacion(nombre:'Estacionamiento N.º 1 Pinacoteca',ubicacion:'Lorenzo Arenas 123456',disponibilidad:'bajo',favorito: true),
    CardEstacion(nombre:'Estacionamiento N.º 2 Pinacoteca',ubicacion:'Lorenzo Arenas 123457',disponibilidad:'lleno',favorito: false),
    CardEstacion(nombre:'Estacionamiento Biblioteca Central',ubicacion:'Lorenzo Arenas 987654',disponibilidad:'no disponible',favorito: true),
    CardEstacion(nombre:'Facultad de Ingenieria',ubicacion:'Lorenzo Arenas 1313',disponibilidad:'medio',favorito: false),
    CardEstacion(nombre:'Estacionamiento N.º 1 Pinacoteca',ubicacion:'Lorenzo Arenas 123456',disponibilidad:'bajo',favorito: true),
    CardEstacion(nombre:'Estacionamiento N.º 2 Pinacoteca',ubicacion:'Lorenzo Arenas 123457',disponibilidad:'lleno',favorito: false),
    CardEstacion(nombre:'Estacionamiento Biblioteca Central',ubicacion:'Lorenzo Arenas 987654',disponibilidad:'no disponible',favorito: true),
    CardEstacion(nombre:'Facultad de Ingenieria',ubicacion:'Lorenzo Arenas 1313',disponibilidad:'medio',favorito: false),
    CardEstacion(nombre:'Estacionamiento N.º 1 Pinacoteca',ubicacion:'Lorenzo Arenas 123456',disponibilidad:'bajo',favorito: true),
    CardEstacion(nombre:'Estacionamiento N.º 2 Pinacoteca',ubicacion:'Lorenzo Arenas 123457',disponibilidad:'lleno',favorito: false),
    CardEstacion(nombre:'Estacionamiento Biblioteca Central',ubicacion:'Lorenzo Arenas 987654',disponibilidad:'no disponible',favorito: true),
    CardEstacion(nombre:'Facultad de Ingenieria',ubicacion:'Lorenzo Arenas 1313',disponibilidad:'medio',favorito: false),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: azulUdec,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Estacionamientos',
                  style: TextStyle(
                     color: Colors.white,
                  ),
                ),
                 Text('Universidad de Concepción',
                  style: TextStyle(
                     color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: screenHeight/6,
        backgroundColor: naranjaUdec,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(screenWidth, 40.0),
          ),
        ),
        elevation: 10.0,
        shadowColor: negroUdec,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 0.0, right: 20.0, left: 20.0,top: 40.0),
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 0, left: 0,top: 0.0),
            child: cards[index]);
        },
      ),
    );
  }
}