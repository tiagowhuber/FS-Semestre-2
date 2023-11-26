import 'package:flutter/material.dart';
import 'package:frontend_app/screens/admin/camaras.dart';
import 'package:frontend_app/screens/admin/estacionamientos.dart';
import 'package:frontend_app/screens/admin/usuarios.dart';
import 'package:frontend_app/screens/menu_estacionamientos.dart';
import 'package:frontend_app/utils/colors.dart';

class AdminPage extends StatelessWidget {
  final String userName;
  const AdminPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: naranjaUdec,
        title: Text(
          '$userName - ADMINISTRADOR',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: azulUdec,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildButton(
              context,
              'Estacionamientos',
              () {
                _navigateToPage(context, const EstacionamientosAdmin());
              },
            ),
            _buildButton(
              context,
              'Cámaras',
              () {
                _navigateToPage(context, const Camaras());
              },
            ),
            _buildButton(
              context,
              'Usuarios',
              () {
                _navigateToPage(context, const ListaUsuarios());
              },
            ),
            _buildButton(
              context,
              'Ir a la App',
              () {
                _navigateToPage(
                    context, const MenuEstacionamientos(isHandicapped: false));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(
              colors: [naranjaUdec, Colors.deepOrangeAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Container(
            height: 60.0,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
