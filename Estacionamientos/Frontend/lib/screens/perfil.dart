import 'package:flutter/material.dart';
import 'package:frontend_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend_app/screens/menu_estacionamientos.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff023059),
      appBar: AppBar(
        toolbarHeight: screenHeight / 8,
        backgroundColor: naranjaUdec,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(screenWidth, 40.0),
          ),
        ),
        elevation: 15.0,
        shadowColor: negroUdec,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 2, 10, 20),
            height: screenHeight/5,
            width: screenHeight/5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://dthezntil550i.cloudfront.net/f4/latest/f41908291942413280009640715/1280_960/1b2d9510-d66d-43a2-971a-cfcbb600e7fe.png'),
                ),
                border: Border.all(color: Colors.white, width: 6.0)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 2, 10, 20),
            width: screenWidth,
            decoration: BoxDecoration(
              color: amarilloUdec,
              borderRadius: BorderRadius.circular(6),
            ),
            height: 28,
            child: Text(
              'Michael Ignacio Villanueva Torres',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1,
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 2, 10, 20),
            constraints: const BoxConstraints(
              maxHeight: 280,
              maxWidth: 254,
            ),
            height: 30,
            width: screenWidth / 4,
            decoration: BoxDecoration(
              color: naranjaUdec,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Editar',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1,
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 20),
            constraints: const BoxConstraints(
              maxHeight: 280,
            ),
            width: screenWidth,
            height: 28,
            color: amarilloUdec,
            child: Text(
              'Datos Personales',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1,
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 2, 10, 20),
              width: screenWidth,
              height: screenHeight / 6,
              decoration: BoxDecoration(
                color: const Color.fromARGB(136, 2, 69, 128),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Correo: mvillanuvea2019@udec.cl',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: const Color(0xffffffff),
                    ),
                  ),
                  Text(
                    'Ocupacion: Estudiante',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: const Color(0xffffffff),
                    ),
                  ),
                  Text(
                    'N° de celular: 992839283',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: SizedBox(
              width: double.infinity,
              height: 95,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xf9f27d16),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30)),
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
    ));
  }
}
