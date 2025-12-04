enum Calaca {
  rey,
  campesino,
  Sacerdote,
  Villano,
  enamorado,
  verdugo;


  String get simbolo {
    switch (this) {
      case Calaca.rey:
        return 'R';
      case Calaca.campesino:
        return 'C';
      case Calaca.Sacerdote:
        return 'S';
      case Calaca.Villano:
        return 'V';
      case Calaca.enamorado:
        return 'E';
      case Calaca.verdugo:
        return 'B';
    }
  }
  static Calaca? deSimbolo(String simbolo) {
    switch (simbolo.toUpperCase()) {
      case 'R':
        return Calaca.rey;
      case 'C':
        return Calaca.campesino;
      case 'S':
        return Calaca.Sacerdote;
      case 'V':
        return Calaca.Villano;
      case 'E':
        return Calaca.enamorado;
      case 'B':
        return Calaca.verdugo;
      default:
        return null;
    }
  }
}