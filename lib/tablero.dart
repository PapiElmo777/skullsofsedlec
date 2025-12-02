import 'calaca.dart';

class Tablero {
  late final List<List> _niveles;

  Tablero() {
    _niveles = [
      List.filled(2, null), // nivel 1
      List.filled(2, null), // nivel 2
      List.filled(3, null), // nivel 3
      List.filled(3, null), // nivel 4
      List.filled(4, null), // nivel 5
      List.filled(4, null), // nivel 6
    ];
  }

  Tablero.desde(List<List> representacion) {
    if (representacion.length != 6) {
      throw ArgumentError('El tablero debe tener solo 6 niveles');
    }

    final tamanosEsperados = [2, 2, 3, 3, 4, 4];
    
    _niveles = [];
    for (int i = 0; i < 6; i++) {
      if (representacion[i].length != tamanosEsperados[i]) {
        throw ArgumentError(
          'Nivel ${i + 1} debe tener ${tamanosEsperados[i]} posiciones, '
          'pero tiene ${representacion[i].length}'
        );
      }

      final nivel = representacion[i].map((simbolo) {
        if (simbolo == '.' || simbolo == ' ') return null;
        return Calaca.deSimbolo(simbolo);
      }).toList();

      _niveles.add(nivel);
    }
  }

  void colocar(int nivel, int posicion, Calaca calaca) {
    if (nivel < 1 || nivel > 6) {
      throw ArgumentError('El nivel debe estar entre 1 y 6');
    }

    final indiceNivel = nivel - 1;
    if (posicion < 0 || posicion >= _niveles[indiceNivel].length) {
      throw ArgumentError(
        'Debe estar entre 0 y ${_niveles[indiceNivel].length - 1}'
      );
    }

    _niveles[indiceNivel][posicion] = calaca;
  }
  //las posicion esta vacia
  Calaca? obtener(int nivel, int posicion) {
    if (nivel < 1 || nivel > 6) return null;
    
    final indiceNivel = nivel - 1;
    if (posicion < 0 || posicion >= _niveles[indiceNivel].length) return null;

    return _niveles[indiceNivel][posicion];
  }
//obtiene las clalcas de un nivel en especifico
  List obtenerNivel(int nivel) {
    if (nivel < 1 || nivel > 6) {
      throw ArgumentError('El nivel debe estar entre 1 y 6');
    }
    return List.from(_niveles[nivel - 1]);
  }
//obtiene el numero de posiciones en nivel
  int tamanoNivel(int nivel) {
    if (nivel < 1 || nivel > 6) return 0;
    return _niveles[nivel - 1].length;
  }
//representacion 
  @override
  String toString() {
    final buffer = StringBuffer();
    for (int i = 0; i < 6; i++) {
      buffer.write('N${i + 1} ');
      for (final calaca in _niveles[i]) {
        buffer.write('[${calaca?.simbolo ?? '.'}] ');
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}