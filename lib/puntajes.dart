import 'calaca.dart';
import 'tablero.dart';

class Puntajes {
  final Tablero tablero;

  Puntajes(this.tablero);
  int _obtenerPar(int nivel) {
    if (nivel <= 2) return 1;
    if (nivel <= 4) return 2;
    return 3;
  }
  int? _obtenerNivelInferiorDeCarta(int nivel) {
    if (nivel % 2 == 1) {
      return nivel + 1;
    }
    return null;
  }
  int _contarEnParDeNiveles(int nivelSuperior) {
    int contador = 0;
    final nivelInferior = nivelSuperior + 1;
    final tamanoSuperior = tablero.tamanoNivel(nivelSuperior);
    for (int pos = 0; pos < tamanoSuperior; pos++) {
      final calaca = tablero.obtener(nivelSuperior, pos);
      if (calaca == Calaca.rey || calaca == Calaca.campesino) {
        contador++;
      }
    }
    final tamanoInferior = tablero.tamanoNivel(nivelInferior);
    for (int pos = 0; pos < tamanoInferior; pos++) {
      final calaca = tablero.obtener(nivelInferior, pos);
      if (calaca == Calaca.rey || calaca == Calaca.campesino) {
        contador++;
      }
    }
    
    return contador;
  }
  int _contarEnNivel(int nivel) {
    int contador = 0;
    final tamano = tablero.tamanoNivel(nivel);
    
    for (int pos = 0; pos < tamano; pos++) {
      final calaca = tablero.obtener(nivel, pos);
      if (calaca == Calaca.rey || calaca == Calaca.campesino) {
        contador++;
      }
    }
    
    return contador;
  }
  int calcularPuntosDeRey(int nivel, int posicion) {
    final calaca = tablero.obtener(nivel, posicion);
    if (calaca != Calaca.rey) return 0;
    
    int puntos = 0;
    final parActual = _obtenerPar(nivel);
    final nivelInferior = _obtenerNivelInferiorDeCarta(nivel);
    if (nivelInferior != null) {
      puntos += _contarEnNivel(nivelInferior);
    }
    if (parActual == 1) {
      puntos += _contarEnParDeNiveles(3);
      puntos += _contarEnParDeNiveles(5);
    } else if (parActual == 2) {
      puntos += _contarEnParDeNiveles(5);
    }
    
    return puntos;
  }
  int calcularPuntajeTotal() {
    int puntajeTotal = 0;

    for (int nivel = 1; nivel <= 6; nivel++) {
      final tamano = tablero.tamanoNivel(nivel);
      for (int posicion = 0; posicion < tamano; posicion++) {
        final calaca = tablero.obtener(nivel, posicion);
        if (calaca == Calaca.rey) {
          puntajeTotal += calcularPuntosDeRey(nivel, posicion);
        }
      }
    }

    return puntajeTotal;
  }

  Map<String, dynamic> obtenerReporteDetallado() {
    final detalleReyes = <Map<String, dynamic>>[];
    int puntajeTotal = 0;

    for (int nivel = 1; nivel <= 6; nivel++) {
      final tamano = tablero.tamanoNivel(nivel);
      
      for (int posicion = 0; posicion < tamano; posicion++) {
        final calaca = tablero.obtener(nivel, posicion);
        
        if (calaca == Calaca.rey) {
          final puntos = calcularPuntosDeRey(nivel, posicion);
          puntajeTotal += puntos;
          
          detalleReyes.add({
            'ubicacion': 'N$nivel[$posicion]',
            'puntos': puntos,
          });
        }
      }
    }

    return {
      'puntaje_total': puntajeTotal,
      'detalle_reyes': detalleReyes,
    };
  }
}