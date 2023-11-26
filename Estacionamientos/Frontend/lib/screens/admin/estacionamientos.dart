import 'package:flutter/material.dart';
import 'package:frontend_app/utils/colors.dart';
import 'models/parking.dart';
import 'package:frontend_app/Database/Parking_Database.dart';

class EstacionamientosAdmin extends StatefulWidget {
  const EstacionamientosAdmin({Key? key}) : super(key: key);

  @override
  EstacionamientosAdminState createState() => EstacionamientosAdminState();
}

class EstacionamientosAdminState extends State<EstacionamientosAdmin> {
  late List<Parking> estacionamientos;
  @override
  void initState() {
    super.initState();
    estacionamientos = [];
    ParkingDatabase.instance.readAllParkings().then((estacionamientosList) {
      setState(() {
        estacionamientos = estacionamientosList;
      });
    });
  }

  void _agregarEstacionamiento(Parking estacionamiento) {
    ParkingDatabase.instance
        .createParking(estacionamiento)
        .then((estacionamientoInsertado) {
      setState(() {
        estacionamientos.add(estacionamientoInsertado);
      });
    });
  }

  Future<void> _mostrarDialogoAgregarEstacionamiento(
      BuildContext context) async {
    final estacionamiento = await showDialog<Parking>(
      context: context,
      builder: (BuildContext context) {
        return _FormAgregarEstacionamiento();
      },
    );

    if (estacionamiento != null) {
      _agregarEstacionamiento(estacionamiento);
    }
  }

  Future<void> _mostrarDialogoEditarEstacionamiento(
      BuildContext context, Parking estacionamiento) async {
    final nuevoEstacionamiento = await showDialog<Parking>(
      context: context,
      builder: (BuildContext context) {
        return _FormEditarEstacionamiento(estacionamiento: estacionamiento);
      },
    );

    // si se edito el estacionamiento
    if (nuevoEstacionamiento != null) {
      // trucheria
      // crear un parking nuevo temporal que contiene el id del parking original y los datos del parking nuevo (datos obtenidos del form)
      // porque nuevoEstacionamiento tiene id null (se crea en el form)
      Parking parking2 =
          nuevoEstacionamiento.copy(parkingid: estacionamiento.parkingid);

      ParkingDatabase.instance.updateParking(parking2).then((result) {
        if (result > 0) {
          setState(() {
            estacionamientos[estacionamientos.indexOf(estacionamiento)] =
                parking2;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: naranjaUdec,
        title: const Text('Estacionamientos',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: azulUdec,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _mostrarDialogoAgregarEstacionamiento(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      naranjaUdec, // Cambia el color de fondo a naranja
                ),
                child: const Text(
                  'Agregar Estacionamiento',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: estacionamientos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      estacionamientos[index].location,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(estacionamientos[index].type,
                            style: const TextStyle(color: Colors.white)),
                        Text(estacionamientos[index].state,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () => _mostrarDialogoEditarEstacionamiento(
                              context, estacionamientos[index]),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onPressed: () => _quitarEstacionamiento(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _quitarEstacionamiento(int index) async {
    int? idAEliminar = estacionamientos[index].parkingid;

    int result = await ParkingDatabase.instance.deleteParking(idAEliminar!);

    if (result > 0) {
      setState(() {
        estacionamientos.removeAt(index);
      });
    }
  }
}

// --------------------- FORM AGREGAR ESTACIONAMIENTO NUEVO ---------------------

class _FormAgregarEstacionamiento extends StatefulWidget {
  @override
  _FormAgregarEstacionamientoState createState() =>
      _FormAgregarEstacionamientoState();
}

class _FormAgregarEstacionamientoState
    extends State<_FormAgregarEstacionamiento> {
  final _nombreController = TextEditingController();
  final _locationController = TextEditingController();
  String _state = 'Disponible';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Agregar Estacionamiento',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: azulUdec,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Ubicación',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: naranjaUdec),
                ),
              ),
              cursorColor: naranjaUdec,
            ),
            TextField(
              controller: _locationController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Tipo',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: naranjaUdec),
                ),
              ),
              cursorColor: naranjaUdec,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Radio(
                  value: 'Disponible',
                  groupValue: _state,
                  onChanged: (value) {
                    setState(() {
                      _state = value.toString();
                    });
                  },
                  activeColor: naranjaUdec,
                ),
                const Text(
                  'Disponible',
                  style: TextStyle(color: Colors.white),
                ),
                Radio(
                  value: 'No Disponible',
                  groupValue: _state,
                  onChanged: (value) {
                    setState(() {
                      _state = value.toString();
                    });
                  },
                  activeColor: naranjaUdec,
                ),
                const Text(
                  'No Disponible',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            final estacionamiento = Parking(
              location: _nombreController.text,
              type: _locationController.text,
              state: _state,
            );
            Navigator.of(context).pop(estacionamiento);
          },
          child: const Text(
            'Agregar',
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

// --------------------- FORM EDITAR ESTACIONAMIENTO ---------------------

class _FormEditarEstacionamiento extends StatefulWidget {
  final Parking estacionamiento;

  const _FormEditarEstacionamiento({required this.estacionamiento});

  @override
  _FormEditarEstacionamientoState createState() =>
      _FormEditarEstacionamientoState();
}

class _FormEditarEstacionamientoState
    extends State<_FormEditarEstacionamiento> {
  late TextEditingController _nombreController;
  late TextEditingController _locationController;
  late TextEditingController _stateController;

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.estacionamiento.location);
    _locationController =
        TextEditingController(text: widget.estacionamiento.type);
    _stateController =
        TextEditingController(text: widget.estacionamiento.state);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Editar Estacionamiento',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: azulUdec,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Ubicación',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: naranjaUdec),
                ),
              ),
              cursorColor: naranjaUdec,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Tipo',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: naranjaUdec),
                ),
              ),
              cursorColor: naranjaUdec,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _stateController,
              decoration: const InputDecoration(
                labelText: 'Disponibilidad',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: naranjaUdec),
                ),
              ),
              cursorColor: naranjaUdec,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            final nuevoEstacionamiento = Parking(
              location: _nombreController.text,
              type: _locationController.text,
              state: _stateController.text,
            );
            Navigator.of(context).pop(nuevoEstacionamiento);
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
