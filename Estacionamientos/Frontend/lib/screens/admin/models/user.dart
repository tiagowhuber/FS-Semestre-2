enum Tipo {
  comun,
  discapacitado,
  reserva,
  suspendido,
}

class User {
  final String email;
  Tipo tipo;

  User({
    required this.email,
    required this.tipo,
  });
}
