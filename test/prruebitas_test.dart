import 'package:test/test.dart';
import '../lib/calaca.dart';
import '../lib/tablero.dart';
import '../lib/puntajes.dart';
import '../lib/puntajesVillanos.dart';
import '../lib/puntajesEnamorados.dart';
import '../lib/puntajesCampesinos.dart';
import '../lib/puntajesVerdugo.dart';

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
  //campesinos
    test('puntua 3 campesinos arriba del rey', () {
      final tablero = Tablero.desde([
        ['C', '.'],
        ['C', 'C'],
        ['C', 'R', '.'],
        ['R', '.', '.'],
        ['.', 'R', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = PuntajesCampesinos(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(6));
    });
    test('puntua 4 campesinos sin rey', () {
      final tablero = Tablero.desde([
        ['C', '.'],
        ['C', 'C'],
        ['C', 'E', '.'],
        ['.', '.', '.'],
        ['.', '.', '.', '.'],
        ['R', '.', '.', '.'],
      ]);

      final puntajes = PuntajesCampesinos(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(8));
    });

    //Mata reyes

  test('villanos matan a rey: 0 Puntos', () {
      final tablero = Tablero.desde([
        ['V', '.'],
        ['R', '.'],
        ['.', 'V', '.'],
        ['.', '.', '.'],
        ['C', 'C', 'C', 'C'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Rey Corrupto (Vertical/Diagonal):');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(0));
    });

  test('Rey puntua porque no hay villanos suficientes: 3', () {
      final tablero = Tablero.desde([
        ['R', 'V'],
        ['C', '.'],
        ['R', 'C', 'V'],
        ['.', '.', '.'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = Puntajes(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(3));
    });

    test('campecinos puntuan', () {
      final tablero = Tablero.desde([
        ['V', '.'],
        ['R', '.'],
        ['V', 'V', '.'],
        ['R', 'V', '.'],
        ['C', 'C', 'C', 'C'],
        ['.', 'C', 'C', '.'],
      ]);
      final puntajes = PuntajesCampesinos(tablero); 
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Rey Eliminado (Campesinos libres):');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(6));
    });

    test('campecinos puntuan', () {
      final tablero = Tablero.desde([
        ['S', 'V'],
        ['S', 'C'],
        ['V', 'R', 'C'],
        ['C', 'V', 'E'],
        ['C', 'C', 'R', 'S'],
        ['V', 'S', 'S', 'E'],
      ]);
      final puntajes = PuntajesCampesinos(tablero); 
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Rey Eliminado (Campesinos libres):');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(6));
    });

    // Verdugos
    test('Varios verdugos)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['B', 'V'], //1
        ['.', 'B', '.'],//4
        ['V', 'V', 'V'],
        ['B', '.', '.', '.'],
        ['.', '.', '.', 'V'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(8));
    });
    test('Varios verdugos)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['.', 'V'], //1
        ['.', 'B', '.'],//4
        ['V', 'V', 'V'],
        ['B', '.', '.', '.'],
        ['.', '.', '.', 'V'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(7));
    });

    test('EJEMPLO 1)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['B', '.'], //1
        ['V', '.', '.'],//4
        ['V', '.', '.'],
        ['.', 'V', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(3));// ESTA BIEN 
    });
    test('EJEMPLO 2)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['B', 'V'], //1
        ['V', '.', 'V'],//4
        ['V', '.', '.'],
        ['.', 'V', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(5));//4
    });
    test('EJEMPLO 3)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['B', 'V'], //1
        ['V', 'B', 'V'],//4
        ['V', '.', '.'],
        ['.', 'V', '.', '.'],
        ['.', '.', '.', '.'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(10));
    });
    test('EJEMPLO 4)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['B', 'V'], //1
        ['V', 'B', 'V'],//4
        ['V', '.', '.'],
        ['.', 'V', '.', '.'],
        ['.', '.', 'V', '.'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(10));
    });
    test('EJEMPLO 5)', () {
      final tablero = Tablero.desde([
        ['.', '.'],
        ['B', 'V'], //1
        ['V', 'B', 'V'],//4
        ['V', '.', '.'],
        ['.', 'V', '.', '.'],
        ['B', '.', 'V', '.'],
      ]);

      final puntajes = PuntajesVerdugo(tablero);
      final puntos = puntajes.calcularPuntajeTotal();
      
      print('Tablero Verdugo Cadena Rota:');
      print(tablero);
      print('Total de puntos: $puntos');
      
      expect(puntos, equals(10));
    });


}