import 'calaca.dart';
import 'tablero.dart';

class PuntajesVillanos {
  final Tablero tablero;

  PuntajesVillanos(this.tablero);
  bool _haySacerdoteEn(int nivel, int posicion) {
    final calaca = tablero.obtener(nivel, posicion);
    return calaca == Calaca.Sacerdote;
  }
  bool tieneVecinoSacerdote(int nivel, int posicion) {
    final calaca = tablero.obtener(nivel, posicion);
    if (calaca != Calaca.Villano) return false;
    if (nivel > 1) {
      if (_haySacerdoteEn(nivel - 1, posicion)) return true;
    }
    if (nivel < 6) {
      if (_haySacerdoteEn(nivel + 1, posicion)) return true;
    }
    if (posicion > 0) {
      if (_haySacerdoteEn(nivel, posicion - 1)) return true;
      }
    final tamanoNivel = tablero.tamanoNivel(nivel);
    if (posicion < tamanoNivel - 1) {
      if (_haySacerdoteEn(nivel, posicion + 1)) return true;
    }

    return false;
  }
  int calcularPuntosDeVillano(int nivel, int posicion) {
    if (tieneVecinoSacerdote(nivel, posicion)) {
      return 2;
    }
    return 0;
  }
  int calcularPuntajeTotal() {
    int puntajeTotal = 0;

    for (int nivel = 1; nivel <= 6; nivel++) {
      final tamano = tablero.tamanoNivel(nivel);
      
      for (int posicion = 0; posicion < tamano; posicion++) {
        final calaca = tablero.obtener(nivel, posicion);
        
        if (calaca == Calaca.Villano) {
          puntajeTotal += calcularPuntosDeVillano(nivel, posicion);
        }
      }
    }

    return puntajeTotal;
  }
  Map<String, dynamic> obtenerReporteDetallado() {
    final villanosQuePuntuan = <String>[];
    final villanosQueNoPuntuan = <String>[];
    int puntajeTotal = 0;

    for (int nivel = 1; nivel <= 6; nivel++) {
      final tamano = tablero.tamanoNivel(nivel);
      
      for (int posicion = 0; posicion < tamano; posicion++) {
        final calaca = tablero.obtener(nivel, posicion);
        
        if (calaca == Calaca.Villano) {
          final ubicacion = 'N$nivel[$posicion]';
          
          if (tieneVecinoSacerdote(nivel, posicion)) {
            villanosQuePuntuan.add(ubicacion);
            puntajeTotal += 2;
          } else {
            villanosQueNoPuntuan.add(ubicacion);
          }
        }
      }
    }

    return {
      'puntaje_total': puntajeTotal,
      'villanos_que_puntuan': villanosQuePuntuan,
      'villanos_que_no_puntuan': villanosQueNoPuntuan,
    };
  }
}