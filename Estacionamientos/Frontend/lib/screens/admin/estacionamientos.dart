import 'package:flutter/material.dart';
import 'models/estacionamiento.dart';

class EstacionamientosAdmin extends StatefulWidget {
  const EstacionamientosAdmin({Key? key}) : super(key: key);

  @override
  EstacionamientosAdminState createState() => EstacionamientosAdminState();
}

class EstacionamientosAdminState extends State<EstacionamientosAdmin> {
  // datos ejemplo
  List<Estacionamiento> estacionamientos = [
    Estacionamiento(
      nombre: 'Estacionamiento N.º 1 Pinacoteca',
      ubicacion: 'Lorenzo Arenas 123456',
      disponibilidad: 'bajo',
    ),
    Estacionamiento(
      nombre: 'Estacionamiento N.º 2 Pinacoteca',
      ubicacion: 'Lorenzo Arenas 123457',
      disponibilidad: 'lleno',
    ),
    Estacionamiento(
      nombre: 'Estacionamiento Biblioteca Central',
      ubicacion: 'Lorenzo Arenas 987654',
      disponibilidad: 'no disponible',
    ),
    Estacionamiento(
      nombre: 'Facultad de Ingenieria',
      ubicacion: 'Lorenzo Arenas 1313',
      disponibilidad: 'medio',
    ),
  ];

  void _agregarEstacionamiento(Estacionamiento estacionamiento) {
    setState(() {
      estacionamientos.add(estacionamiento);
    });
  }

  Future<void> _mostrarDialogoAgregarEstacionamiento(
      BuildContext context) async {
    final estacionamiento = await showDialog<Estacionamiento>(
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
      BuildContext context, Estacionamiento estacionamiento) async {
    final nuevoEstacionamiento = await showDialog<Estacionamiento>(
      context: context,
      builder: (BuildContext context) {
        return _FormEditarEstacionamiento(estacionamiento: estacionamiento);
      },
    );

    if (nuevoEstacionamiento != null) {
      // Reemplazar el estacionamiento antiguo con el editado
      setState(() {
        estacionamientos[estacionamientos.indexOf(estacionamiento)] =
            nuevoEstacionamiento;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estacionamientos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _mostrarDialogoAgregarEstacionamiento(context),
                child: const Text('Agregar Estacionamiento'),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: estacionamientos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(estacionamientos[index].nombre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(estacionamientos[index].ubicacion),
                        Text(estacionamientos[index].disponibilidad),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _mostrarDialogoEditarEstacionamiento(
                              context, estacionamientos[index]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
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

  void _quitarEstacionamiento(int index) {
    setState(() {
      estacionamientos.removeAt(index);
    });
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
  final _ubicacionController = TextEditingController();
  String _disponibilidad = 'Disponible';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Estacionamiento'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _ubicacionController,
              decoration: const InputDecoration(labelText: 'Ubicación'),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Radio(
                  value: 'Disponible',
                  groupValue: _disponibilidad,
                  onChanged: (value) {
                    setState(() {
                      _disponibilidad = value.toString();
                    });
                  },
                ),
                const Text('Disponible'),
                Radio(
                  value: 'No Disponible',
                  groupValue: _disponibilidad,
                  onChanged: (value) {
                    setState(() {
                      _disponibilidad = value.toString();
                    });
                  },
                ),
                const Text('No Disponible'),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            final estacionamiento = Estacionamiento(
              nombre: _nombreController.text,
              ubicacion: _ubicacionController.text,
              disponibilidad: _disponibilidad,
            );
            Navigator.of(context).pop(estacionamiento);
          },
          child: const Text('Agregar'),
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

// --------------------- FORM EDITAR ESTACIONAMIENTO ---------------------

class _FormEditarEstacionamiento extends StatefulWidget {
  final Estacionamiento estacionamiento;

  const _FormEditarEstacionamiento({required this.estacionamiento});

  @override
  _FormEditarEstacionamientoState createState() =>
      _FormEditarEstacionamientoState();
}

class _FormEditarEstacionamientoState
    extends State<_FormEditarEstacionamiento> {
  late TextEditingController _nombreController;
  late TextEditingController _ubicacionController;
  late TextEditingController _disponibilidadController;

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.estacionamiento.nombre);
    _ubicacionController =
        TextEditingController(text: widget.estacionamiento.ubicacion);
    _disponibilidadController =
        TextEditingController(text: widget.estacionamiento.disponibilidad);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Estacionamiento'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _ubicacionController,
              decoration: const InputDecoration(labelText: 'Ubicación'),
            ),
            TextField(
              controller: _disponibilidadController,
              decoration: const InputDecoration(labelText: 'Disponibilidad'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            final nuevoEstacionamiento = Estacionamiento(
              nombre: _nombreController.text,
              ubicacion: _ubicacionController.text,
              disponibilidad: _disponibilidadController.text,
            );
            Navigator.of(context).pop(nuevoEstacionamiento);
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
