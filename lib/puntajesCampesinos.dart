import 'calaca.dart';
import 'tablero.dart';

class PuntajesCampesinos {
  final Tablero tablero;

  PuntajesCampesinos(this.tablero);
  
  bool _esVillano(int n, int i) {
    if (n < 1 || n > 6) return false;
    final tamano = tablero.tamanoNivel(n);
    if (i < 0 || i >= tamano) return false;
    
    return tablero.obtener(n, i) == Calaca.Villano;
  }

  int _contarVillanosAdyacentes(int n, int i) {
    int villanos = 0;
    if (_esVillano(n, i - 1)) villanos++;
    if (_esVillano(n, i + 1)) villanos++;
    if (n > 1) {
      if (n == 2 || n == 4 || n == 6) {
        if (_esVillano(n - 1, i)) villanos++;
      } else {
        if (_esVillano(n - 1, i)) villanos++;
        if (_esVillano(n - 1, i - 1)) villanos++;
      }
    }
    if (n < 6) {
      if (n == 1 || n == 3 || n == 5) {
        if (_esVillano(n + 1, i)) villanos++;
      } else {
        if (_esVillano(n + 1, i)) villanos++;
        if (_esVillano(n + 1, i + 1)) villanos++;
      }
    }

    return villanos;
  }
  bool _tieneReyValidoAlLado(int nivel, int index, Set<int> nivelesReyesValidos, List<List<bool>> mapaReyesValidos) {
    final tamano = tablero.tamanoNivel(nivel);
    if (index > 0) {
      if (mapaReyesValidos[nivel - 1][index - 1]) return true;
    }
    if (index < tamano - 1) {
      if (mapaReyesValidos[nivel - 1][index + 1]) return true;
    }

    return false;
  }

  int calcularPuntajeTotal() {
    int puntajeTotal = 0;
    final mapaReyesValidos = List.generate(6, (i) {
      final tamano = tablero.tamanoNivel(i + 1);
      return List.filled(tamano, false);
    });
    
    final nivelesConReyValido = <int>{};

    for (int n = 1; n <= 6; n++) {
      final tamano = tablero.tamanoNivel(n);
      for (int i = 0; i < tamano; i++) {
        if (tablero.obtener(n, i) == Calaca.rey) {
          if (_contarVillanosAdyacentes(n, i) < 2) {
            nivelesConReyValido.add(n);
            mapaReyesValidos[n - 1][i] = true;
          }
        }
      }
    }

    final hayReyesValidos = nivelesConReyValido.isNotEmpty;
    for (int n = 1; n <= 6; n++) {
      final tamano = tablero.tamanoNivel(n);
      for (int i = 0; i < tamano; i++) {
        if (tablero.obtener(n, i) == Calaca.campesino) {
          
          if (!hayReyesValidos) {
            puntajeTotal += 1;
          } else {
            if (_tieneReyValidoAlLado(n, i, nivelesConReyValido, mapaReyesValidos)) {
              continue; 
            }
            bool tieneReyValidoAbajo = nivelesConReyValido.any((nivelRey) => nivelRey > n);
            if (tieneReyValidoAbajo) {
              puntajeTotal += 2;
            }
          }
        }
      }
    }

    return puntajeTotal;
  }
}