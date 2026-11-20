import wollok.game.*

object mapa {
  const ancho = 33
  const alto = 25

  const posicionesBloqueadas = #{
    // Fila 24
    game.at(0,24), game.at(1,24), game.at(2,24), game.at(3,24), game.at(4,24), game.at(5,24), game.at(6,24), game.at(7,24), game.at(8,24), game.at(9,24), game.at(10,24), game.at(11,24), game.at(12,24), game.at(13,24), game.at(14,24), game.at(15,24), game.at(16,24), game.at(17,24), game.at(18,24), game.at(19,24), game.at(20,24), game.at(21,24), game.at(22,24), game.at(23,24), game.at(24,24), game.at(25,24), game.at(26,24), game.at(27,24), game.at(28,24), game.at(29,24), game.at(30,24), game.at(31,24), game.at(32,24),
    // Fila 23
    game.at(0,23), game.at(12,23), game.at(13,23), game.at(14,23), game.at(15,23), game.at(16,23), game.at(17,23), game.at(18,23), game.at(19,23), game.at(20,23), game.at(21,23), game.at(27,23), game.at(28,23), game.at(30,23), game.at(31,23), game.at(32,23),
    // Fila 22
    game.at(0,22), game.at(4,22), game.at(5,22), game.at(6,22), game.at(7,22), game.at(8,22), game.at(12,22), game.at(13,22), game.at(14,22), game.at(15,22), game.at(16,22), game.at(17,22), game.at(18,22), game.at(19,22), game.at(20,22), game.at(21,22), game.at(27,22), game.at(28,22), game.at(30,22), game.at(31,22), game.at(32,22),
    // Fila 21
    game.at(0,21), game.at(4,21), game.at(32,21),
    // Fila 20
    game.at(0,20), game.at(4,20), game.at(23,20), game.at(24,20), game.at(25,20), game.at(26,20), game.at(27,20), game.at(32,20),
    // Fila 19
    game.at(0,19), game.at(4,19), game.at(23,19), game.at(32,19),
    // Fila 18
    game.at(0,18), game.at(4,18), game.at(23,18), game.at(32,18),
    // Fila 17
    game.at(0,17), game.at(4,17), game.at(5,17), game.at(6,17), game.at(23,17), game.at(32,17),
    // Fila 16
    game.at(0,16), game.at(6,16), game.at(7,16), game.at(8,16), game.at(13,16), game.at(17,16), game.at(23,16), game.at(32,16),
    // Fila 15
    game.at(0,15), game.at(8,15), game.at(13,15), game.at(17,15), game.at(23,15), game.at(32,15),
    // Fila 14
    game.at(0,14), game.at(8,14), game.at(13,14), game.at(14,14), game.at(15,14), game.at(16,14), game.at(17,14), game.at(20,14), game.at(21,14), game.at(22,14), game.at(23,14), game.at(32,14),
    // Fila 13
    game.at(0,13), game.at(16,13), game.at(26,13), game.at(27,13), game.at(28,13), game.at(29,13), game.at(30,13), game.at(31,13), game.at(32,13),
    // Fila 12
    game.at(0,12), game.at(7,12), game.at(16,12), game.at(25,12), game.at(26,12), game.at(32,12),
    // Fila 11
    game.at(0,11), game.at(7,11), game.at(10,11), game.at(11,11), game.at(12,11), game.at(13,11), game.at(14,11), game.at(15,11), game.at(16,11), game.at(17,11), game.at(25,11), game.at(32,11),
    // Fila 10
    game.at(0,10), game.at(7,10), game.at(20,10), game.at(23,10), game.at(24,10), game.at(25,10), game.at(32,10),
    // Fila 9
    game.at(0,9), game.at(3,9), game.at(4,9), game.at(5,9), game.at(6,9), game.at(7,9), game.at(20,9), game.at(32,9),
    // Fila 8
    game.at(0,8), game.at(20,8), game.at(30,8), game.at(32,8),
    // Fila 7
    game.at(0,7), game.at(20,7), game.at(31,7), game.at(32,7),
    // Fila 6
    game.at(0,6), game.at(20,6), game.at(30,6), game.at(31,6), game.at(32,6),
    // Fila 5
    game.at(0,5), game.at(20,5), game.at(30,5), game.at(32,5),
    // Fila 4
    game.at(0,4), game.at(6,4), game.at(7,4), game.at(8,4), game.at(9,4), game.at(10,4), game.at(11,4), game.at(12,4), game.at(13,4), game.at(14,4), game.at(15,4), game.at(16,4), game.at(17,4), game.at(18,4), game.at(20,4), game.at(21,4), game.at(22,4), game.at(23,4), game.at(24,4), game.at(25,4), game.at(28,4), game.at(29,4), game.at(30,4), game.at(32,4),
    // Fila 3
    game.at(0,3), game.at(32,3),
    // Fila 2
    game.at(0,2), game.at(32,2),
    // Fila 1
    game.at(0,1), game.at(6,1), game.at(32,1),
    // Fila 0
    game.at(0,0), game.at(1,0), game.at(6,0), game.at(7,0), game.at(8,0), game.at(9,0), game.at(10,0), game.at(11,0), game.at(12,0), game.at(13,0), game.at(14,0), game.at(15,0), game.at(16,0), game.at(17,0), game.at(18,0), game.at(19,0), game.at(20,0), game.at(21,0), game.at(22,0), game.at(23,0), game.at(24,0), game.at(25,0), game.at(26,0), game.at(27,0), game.at(28,0), game.at(29,0), game.at(30,0), game.at(31,0), game.at(32,0)
  }

  const grillaBloqueada = (0 .. (ancho * alto - 1)).map({ indice =>
    posicionesBloqueadas.contains(game.at(indice % ancho, indice.div(ancho)))
  })

  method esPosicionLibre(pos) = not self.esPosicionBloqueada(pos)

  method esPosicionBloqueada(pos) =
    not self.estaDentroDeLimites(pos) or grillaBloqueada.get(pos.y() * ancho + pos.x())

  method estaDentroDeLimites(pos) =
    pos.x().between(0, ancho - 1) and pos.y().between(0, alto - 1)
}