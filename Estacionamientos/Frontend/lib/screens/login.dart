import 'package:flutter/material.dart';
import 'package:frontend_app/screens/admin/admin.dart';
import 'package:frontend_app/Database/Parking_Database.dart';
import 'package:frontend_app/screens/admin/models/parking.dart';
import 'package:frontend_app/screens/menu_estacionamientos.dart';
import 'package:frontend_app/screens/perfil.dart';
import 'package:frontend_app/screens/register.dart';
import 'package:frontend_app/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: azulUdec,
      body: Stack(
        children: [
          Container(
            height: screenHeight / 4,
            color: amarilloUdec,
          ),
          ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: (screenHeight / 9) * 4,
                    decoration: const BoxDecoration(
                      color: amarilloUdec,
                    ),
                    child: Image.asset(
                      "assets/images/login_image.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Perfil()),
                            );
                          },
                          child: Icon(
                            Icons.info_outline,
                            size: screenHeight / 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 4,
                color: Colors.black,
              ),
              Container(
                color: azulUdec,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, right: 40.0, left: 40.0, top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Title(
                        color: Colors.white,
                        child: const Text(
                          "Ingresar",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Title(
                            color: Colors.white,
                            child: const Text(
                              "Usuario",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(215, 212, 212, 212),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              controller: _emailController,
                              style: const TextStyle(
                                color:
                                    Colors.white, // Color de la letra deseado
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .white), // Color de la línea de borde al estar seleccionado
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        children: [
                          Title(
                            color: Colors.white,
                            child: const Text(
                              "Contraseña",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(215, 212, 212, 212),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              controller: _passwordController,
                              style: const TextStyle(
                                color:
                                    Colors.white, // Color de la letra deseado
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .white), // Color de la línea de borde al estar seleccionado
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      MaterialButton(
                        height: 80,
                        minWidth: 1000,
                        color: naranjaUdec, // Establecer el color de fondo
                        textColor:
                            Colors.white, // Establecer el color del texto
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          // Attempt to read the user from the database
                          bool user = await ParkingDatabase.instance
                              .readUserByEmailAndPassword(email, password);
                          // Check if the user is found
                          if (user == true) {
                            // get id con el email y password
                            int? id = await ParkingDatabase.instance.getUserID(email, password);
                            // ver si el id corresponde a un id de admin
                            if (id != null && await ParkingDatabase.instance.checkAdmin(id)) {
                              // buscar el usuario con el admin
                              User adminUser = await ParkingDatabase.instance.readUser(id);
                              // redireccionar a pagina de admin con el nombre del admin
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminPage(userName: adminUser.name),),
                                );
                            }else{
                              // buscar el usuario
                               if (id != null){
                              User usuario = await ParkingDatabase.instance.readUser(id);
                            // User found, proceed to MenuEstacionamientos
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuEstacionamientos(
                                     isHandicapped: usuario.tipo == Tipo.discapacitado,)),
                            );}
                            }
                          } else {
                            // User not found, show an error dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                    'Usuario no encontrado. Por favor revisa tu correo electrónico y contraseña.',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      MaterialButton(
                        height: 20,
                        minWidth: null,
                        color: azulUdec, // Establecer el color de fondo
                        elevation: 0,
                        textColor:
                            Colors.white, // Establecer el color del texto
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                          // Aquí puedes agregar la lógica de autenticación y redireccionar al usuario si los datos son válidos.
                          print('Email: $email\nPassword: $password');
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Estacionamientos",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            "Fábrica de Software",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
