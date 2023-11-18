import 'package:flutter/material.dart';
import 'package:frontend_app/utils/colors.dart';
import 'models/parking.dart';
import 'package:frontend_app/Database/Parking_Database.dart';

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({Key? key}) : super(key: key);

  @override
  ListaUsuariosState createState() => ListaUsuariosState();
}

class ListaUsuariosState extends State<ListaUsuarios> {
  late List<User> users;
  @override
  void initState() {
    super.initState();
    users = [];
    ParkingDatabase.instance.readAllUsers().then((userList) {
      setState(() {
        users = userList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: naranjaUdec,
        title: const Text('Usuarios', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: azulUdec,
      body: SingleChildScrollView(
        child: Column(
          children: users.map((user) {
            return ListTile(
              title: Text(
                user.mail,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Tipo: ${_getTipoText(user.tipo)}',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  _mostrarDialogoEditarTipoUsuario(context, user);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // obtener el tipo en string
  String _getTipoText(Tipo tipo) {
    switch (tipo) {
      case Tipo.comun:
        return 'Común';
      case Tipo.discapacitado:
        return 'Discapacitado';
      case Tipo.reserva:
        return 'Reserva';
      case Tipo.suspendido:
        return 'Suspendido';
    }
  }

  Future<void> _mostrarDialogoEditarTipoUsuario(
      BuildContext context, User user) async {
    // dialogo para editar el tipo de usuario
    final nuevoTipo = await showDialog<Tipo>(
      context: context,
      builder: (BuildContext context) {
        return _FormEditarTipoUsuario(tipoActual: user.tipo);
      },
    );

    if (nuevoTipo != null) {
      User tmp = user.copy(
        tipo: nuevoTipo,
      );

      ParkingDatabase.instance.updateUser(tmp).then((result) {
        if (result > 0) {
          setState(() {
            users[users.indexOf(user)] = tmp;
          });
        }
      });
    }
  }
}

// ------------------------------- FORM EDITAR TIPO USUARIO -------------------------------

class _FormEditarTipoUsuario extends StatefulWidget {
  final Tipo tipoActual;

  const _FormEditarTipoUsuario({
    required this.tipoActual,
    Key? key,
  }) : super(key: key);

  @override
  _FormEditarTipoUsuarioState createState() => _FormEditarTipoUsuarioState();
}

class _FormEditarTipoUsuarioState extends State<_FormEditarTipoUsuario> {
  late Tipo _nuevoTipo;

  @override
  void initState() {
    super.initState();
    _nuevoTipo = widget.tipoActual;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: azulUdec,
      title: const Text(
        'Editar tipo de usuario',
        style: TextStyle(color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Tipo>(
              title: const Text(
                'Común',
                style: TextStyle(color: Colors.white),
              ),
              value: Tipo.comun,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
              activeColor: naranjaUdec,
            ),
            RadioListTile<Tipo>(
              title: const Text(
                'Discapacitado',
                style: TextStyle(color: Colors.white),
              ),
              value: Tipo.discapacitado,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
              activeColor: naranjaUdec,
            ),
            RadioListTile<Tipo>(
              title: const Text(
                'Reserva',
                style: TextStyle(color: Colors.white),
              ),
              value: Tipo.reserva,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
              activeColor: naranjaUdec,
            ),
            RadioListTile<Tipo>(
              title: const Text(
                'Suspendido',
                style: TextStyle(color: Colors.white),
              ),
              value: Tipo.suspendido,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
              activeColor: naranjaUdec,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_nuevoTipo);
          },
          child: const Text(
            'Guardar',
            style: TextStyle(color: naranjaUdec),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(color: naranjaUdec),
          ),
        ),
      ],
    );
  }
}
