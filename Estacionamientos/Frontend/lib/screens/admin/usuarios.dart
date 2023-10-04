import 'package:flutter/material.dart';
import 'models/user.dart';

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
    // Inicialización ficticia de usuarios (se remplazará con datos de la BD)
    users = [
      User(email: 'user1@udec.cl', tipo: Tipo.comun),
      User(email: 'user2@udec.cl', tipo: Tipo.discapacitado),
      User(email: 'user3@udec.cl', tipo: Tipo.reserva),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: users.map((user) {
            return ListTile(
              title: Text(user.email),
              subtitle: Text('Tipo: ${_getTipoText(user.tipo)}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
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
      setState(() {
        user.tipo = nuevoTipo;
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
      title: const Text('Editar tipo de usuario'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Tipo>(
              title: const Text('Común'),
              value: Tipo.comun,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
            ),
            RadioListTile<Tipo>(
              title: const Text('Discapacitado'),
              value: Tipo.discapacitado,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
            ),
            RadioListTile<Tipo>(
              title: const Text('Reserva'),
              value: Tipo.reserva,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
            ),
            RadioListTile<Tipo>(
              title: const Text('Suspendido'),
              value: Tipo.suspendido,
              groupValue: _nuevoTipo,
              onChanged: (value) {
                setState(() {
                  _nuevoTipo = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_nuevoTipo);
          },
          child: const Text('Guardar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
