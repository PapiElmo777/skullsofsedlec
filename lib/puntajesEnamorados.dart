import 'calaca.dart';
import 'tablero.dart';
import 'dart:math';

class _Posicion {
  final int nivel;
  final int index;
  _Posicion(this.nivel, this.index);
  
  @override
  String toString() => 'N$nivel[$index]';
}

class PuntajesEnamorados {
  final Tablero tablero;
  final Map<int, int> _memo = {};

  PuntajesEnamorados(this.tablero);

  int calcularPuntajeTotal() {
    final enamorados = <_Posicion>[];
    for (int n = 1; n <= 6; n++) {
      final tamano = tablero.tamanoNivel(n);
      for (int i = 0; i < tamano; i++) {
        if (tablero.obtener(n, i) == Calaca.enamorado) {
          enamorados.add(_Posicion(n, i));
        }
      }
    }

    _memo.clear();
    return _calcularMaximoParejas(0, enamorados) * 6;
  }

  int _calcularMaximoParejas(int mask, List<_Posicion> enamorados) {
    if (_memo.containsKey(mask)) return _memo[mask]!;

    int primerDisponible = -1;
    for (int i = 0; i < enamorados.length; i++) {
      if ((mask & (1 << i)) == 0) {
        primerDisponible = i;
        break;
      }
    }

    if (primerDisponible == -1) return 0;
    int maxPuntos = _calcularMaximoParejas(mask | (1 << primerDisponible), enamorados);
    for (int j = primerDisponible + 1; j < enamorados.length; j++) {
      if ((mask & (1 << j)) != 0) continue;

      if (_sonAdyacentes(enamorados[primerDisponible], enamorados[j])) {
        final nuevaMask = mask | (1 << primerDisponible) | (1 << j);
        final puntos = 1 + _calcularMaximoParejas(nuevaMask, enamorados);
        maxPuntos = max(maxPuntos, puntos);
      }
    }

    _memo[mask] = maxPuntos;
    return maxPuntos;
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
        return (arriba.index - abajo.index).abs() <= 1;
      } 
      else if (arriba.nivel == 2 || arriba.nivel == 4) {
        return abajo.index == arriba.index || abajo.index == arriba.index + 1;
      }
    }

    return false;
  }
}