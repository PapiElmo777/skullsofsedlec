import 'calaca.dart';
import 'tablero.dart';
import 'dart:collection';

class _Posicion {
  final int nivel;
  final int index;
  _Posicion(this.nivel, this.index);
  
  @override
  bool operator ==(Object other) =>
      other is _Posicion && other.nivel == nivel && other.index == index;

  @override
  int get hashCode => Object.hash(nivel, index);

  @override
  String toString() => 'N$nivel[$index]';
}

class PuntajesVerdugo {
  final Tablero tablero;

  PuntajesVerdugo(this.tablero);

  int calcularPuntajeTotal() {
    int puntajeTotal = 0;
    final verdugos = <_Posicion>[];
    for (int n = 1; n <= 6; n++) {
      final tamano = tablero.tamanoNivel(n);
      for (int i = 0; i < tamano; i++) {
        if (tablero.obtener(n, i) == Calaca.verdugo) {
          verdugos.add(_Posicion(n, i));
        }
      }
    }
    for (final verdugo in verdugos) {
      puntajeTotal += _contarVillanosConectados(verdugo);
    }

    return puntajeTotal;
  }

  int _contarVillanosConectados(_Posicion inicio) {
    final cola = Queue<_Posicion>();
    cola.add(inicio);
    final procesados = <_Posicion>{inicio};

    int villanosEncontrados = 0;

    while (cola.isNotEmpty) {
      final actual = cola.removeFirst();
      final vecinos = _obtenerVecinos(actual);

      for (final vecino in vecinos) {
        if (procesados.contains(vecino)) continue;

        final tipo = tablero.obtener(vecino.nivel, vecino.index);
        if (tipo == Calaca.Villano) {
          procesados.add(vecino);
          cola.add(vecino);
          villanosEncontrados++;
        }
      }
    }

    return villanosEncontrados;
  }

  List<_Posicion> _obtenerVecinos(_Posicion pos) {
    final vecinos = <_Posicion>[];
    final n = pos.nivel;
    for (int nivelVecino = n - 1; nivelVecino <= n + 1; nivelVecino++) {
      if (nivelVecino < 1 || nivelVecino > 6) continue;
      
      final tamano = tablero.tamanoNivel(nivelVecino);
      for (int indexVecino = 0; indexVecino < tamano; indexVecino++) {
        final candidato = _Posicion(nivelVecino, indexVecino);
        if (candidato == pos) continue;

        if (_sonAdyacentes(pos, candidato)) {
          vecinos.add(candidato);
        }
      }
    }
    return vecinos;
  }

  bool _sonAdyacentes(_Posicion a, _Posicion b) {
    final diffNivel = (a.nivel - b.nivel).abs();
    if (diffNivel == 0) {
      return (a.index - b.index).abs() == 1;
    }
    if (diffNivel == 1) {
      final arriba = a.nivel < b.nivel ? a : b;
      final abajo = a.nivel < b.nivel ? b : a;
      if (arriba.nivel == 1 || arriba.nivel == 3 || arriba.nivel == 5) {
        return arriba.index == abajo.index; 
      }
      else if (arriba.nivel == 2 || arriba.nivel == 4) {
        return abajo.index == arriba.index || abajo.index == arriba.index + 1;
      }
    }

    return false;
  }
}