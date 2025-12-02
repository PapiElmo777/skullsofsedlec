import 'package:test/test.dart';
import '../lib/calaca.dart';
import '../lib/tablero.dart';
import '../lib/puntajes.dart';
import '../lib/puntajesVillanos.dart';
import '../lib/puntajesEnamorados.dart';

void main() {
    test('Rey con Campesino en nivel inferior de su carta: 1 punto', () {
      final tablero = Tablero.desde([
        ['R', '.'],
        ['C', '.'],
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(1));
    });

    test('Rey con Rey en nivel inferior de su carta: 1 punto', () {
      final tablero = Tablero.desde([
        ['R', '.'],
        ['R', '.'],
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(1));
    });

    test('Solo un rey: 0 puntos', () {
      final tablero = Tablero.desde([
        ['R', '.'],
        ['.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(0));
    });

    test('Solo campesinos: 0 puntos', () {
      final tablero = Tablero.desde([
        ['C', '.'],          
        ['C', '.'],         
        ['C', '.', '.'],     
        ['.', '.', '.'],     
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'], 
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(0));
    });

    test('Tablero vacío: 0 puntos', () {
      final tablero = Tablero.desde([
        ['.', '.'],          
        ['.', '.'],          
        ['.', '.', '.'],     
        ['.', '.', '.'],     
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'], 
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(0));
    });

    test('Tablero pizarrón ejemplo: 11 puntos', () {
      final tablero = Tablero.desde([
        ['.', 'R'],
        ['.', '.'],
        ['.', 'R', '.'],
        ['.', '.', '.'],
        ['R', '.', 'C', '.'],
        ['.', 'C', '.', 'C'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      final reporte = puntajes.obtenerReporteDetallado();
      print(tablero);
      print('Detalle de Reyes:');
      for (final detalle in reporte['detalle_reyes']) {
        print('  ${detalle['ubicacion']}: ${detalle['puntos']} puntos');
      }
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(11));
    });

    test('Rey en N1 busca en N3-N4 y N5-N6', () {
      final tablero = Tablero.desde([
        ['R', '.'],
        ['.', '.'],
        ['C', '.', '.'],
        ['C', '.', '.'],
        ['R', '.', '.', '.'],
        ['C', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(5));
    });


    test('Rey en N5 solo busca en N6', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['R', '.', '.', '.'],
        ['C', 'C', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(2));
    });

    test('Rey en N2 busca en N3-N4 y N5-N6', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['R', '.'],
        ['C', '.', '.'],
        ['.', '.', '.'],
        ['R', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(2));
    });

    //sacerdotes
  test('10 puntos', () {
    final tablero = Tablero.desde([
      ['S', '.'], 
      ['V', 'V'], 
      ['V', 'S', '.'],
      ['.', 'V', '.'],
      ['V', '.', 'V', '.'],
      ['.', '.', 'S', '.'],
    ]);

    final puntajes = PuntajesVillanos(tablero);
    final puntos = puntajes.calcularPuntajeTotal();
    print(tablero);
    print('Total de puntos: $puntos');
    
    expect(puntos, equals(10));
  });
  //enamorados
  test('Dos parejas: 12 puntos', () {
      
      final tablero = Tablero.desde([
        ['.', '.'],
        ['E', '.'],
        ['.', 'E', 'E'],
        ['.', '.', 'E'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = PuntajesEnamorados(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Enamorados:');
      print(tablero);
      print('Puntos totales: $puntos');

      expect(puntos, equals(12)); 
    });
    test('Tres parejas 18 puntos y dos solos)', () {
      
      final tablero = Tablero.desde([
        ['.', 'E'],
        ['E', '.'],
        ['.', 'E', 'E'],
        ['.', 'E', 'E'],
        ['.', 'E', '.', '.'],
        ['E', '.', 'E', '.'],
      ]);

      final puntajes = PuntajesEnamorados(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Enamorados:');
      print(tablero);
      print('Puntos totales: $puntos');

      expect(puntos, equals(24)); 
    });
    test('Cuatro parejas: 24 puntos', () {
      
      final tablero = Tablero.desde([
        ['.', '.'],
        ['.', '.'],
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E'],
      ]);

      final puntajes = PuntajesEnamorados(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Malla:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(24));
    });
    test('Cuatro parejas: 24 puntos', () {
      
      final tablero = Tablero.desde([
        ['.', '.'],
        ['.', 'E'],
        ['.', 'E', 'E'],
        ['.', 'E', 'E'],
        ['.', '.', 'E', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = PuntajesEnamorados(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Malla:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(18));
    });
}