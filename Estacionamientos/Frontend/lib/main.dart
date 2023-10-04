import 'package:flutter/material.dart';
import 'package:frontend_app/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      //home: const MenuEstacionamientos(),
      //home: const Cantidad(nombre:'Estacionamiento N.º 1 Pinacoteca',ubicacion: 'Lorenzo Arenas 1234567',),
    );
  }
}
