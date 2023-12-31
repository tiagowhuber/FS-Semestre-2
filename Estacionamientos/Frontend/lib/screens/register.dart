import 'package:flutter/material.dart';
import 'package:frontend_app/Database/Parking_Database.dart';
import 'package:frontend_app/screens/admin/models/parking.dart';
import 'package:frontend_app/screens/login.dart';
import 'package:frontend_app/screens/perfil.dart';
import 'package:frontend_app/utils/colors.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;// This variable tracks the checkbox state

  @override
  void dispose() {
    userController.dispose();
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
          ListView(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Perfil()),
                            );
                          },
                          child: Icon(
                            Icons.info_outline,
                            size: screenHeight/20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                color: azulUdec,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 40.0, left: 40.0, top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Title(
                        color: Colors.white,
                        child: const Text(
                          "Registrar usuario",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 60.0),
                        ],
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
                              controller: userController,
                              style: const TextStyle(
                                color: Colors.white, // Color de la letra deseado
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // Color de la línea de borde al estar seleccionado
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
                                color: Colors.white, // Color de la letra deseado
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // Color de la línea de borde al estar seleccionado
                                ),
                              ),
                              obscureText: true,
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
                              "Mail institucional",
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
                              controller:_emailController,
                              style: const TextStyle(
                                color: Colors.white, // Color de la letra deseado
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // Color de la línea de borde al estar seleccionado
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60.0),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CheckboxListTile(
                            title: Text("Presenta el usuario algun tipo de discapacidad",
                                style: TextStyle(color: Colors.white)
                            ),
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  isChecked = newValue; // Update the state when the checkbox is toggled
                                });
                              }
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          )
                        ],
                      ),
                      const SizedBox(height: 60.0),
                      MaterialButton(
                        height: 80,
                        minWidth: 1000,
                        color: naranjaUdec, // Establecer el color de fondo
                        textColor: Colors.white, // Establecer el color del texto
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          String user = userController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          var usuario = User(name: user, mail: email, password: password, number: 1); // or admin: 0
                          // usuario creado
                          User? created = await ParkingDatabase.instance.createUser(usuario);
                          // checkbox?
                          if (isChecked) {
                            // actualizar usuario a discapacitado
                            User tmp = created.copy(tipo: Tipo.discapacitado);
                            ParkingDatabase.instance.updateUser(tmp);
                          }
                          ParkingDatabase.instance.readAllUsers() ;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                          //print('Email: $email\nPassword: $password');
                          //ParkingDatabase.instance.readAllUsers() ;
                          // SOLO PARA TESTEO DE LA PAGINA ADMIN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                          // BORRAR ESTO EN LA ENTREGA
                          // el primer usuario registrado (con id=1) va ser admin
                          if (!await ParkingDatabase.instance.checkAdmin(1)) {
                            Admin p = const Admin(userid: 1);
                            await ParkingDatabase.instance.createAdmin(p);
                          }
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
