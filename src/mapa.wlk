import wollok.game.*

object mapa {
  const paredes = #{}
  var inicializado = false

  method agregarPared(x, y) { paredes.add(game.at(x, y)) }
  method agregarFila(xs, y) { xs.forEach({ x => self.agregarPared(x, y) }) }
  method agregarColumna(x, ys) { ys.forEach({ y => self.agregarPared(x, y) }) }

  method esPosicionLibre(pos) =
    pos.x().between(0, 32) and pos.y().between(0, 24) and not paredes.contains(pos)

  method esPosicionBloqueada(pos) = not self.esPosicionLibre(pos)

  method inicializarParedes() {
    if (not inicializado) {
      self.construir()
      inicializado = true
    }
  }

  method construir() {
    // bordes limites
    self.agregarFila(0..32, 24)
    self.agregarFila(0..1, 0)
    self.agregarFila(6..32, 0)
    self.agregarColumna(0, 0..24)
    self.agregarColumna(32, 0..24)

    // paredes horizontales internas del laberinto
    [12..21, 27..28, 30..31].forEach({ xs =>
      self.agregarFila(xs, 23)
      self.agregarFila(xs, 22)
    })
    self.agregarFila(4..8, 22)
    self.agregarFila(23..27, 20)
    self.agregarFila(4..6, 17)
    self.agregarFila(6..8, 16)
    self.agregarFila(13..17, 14)
    self.agregarFila(20..23, 14)
    self.agregarFila(26..31, 13)
    self.agregarFila(25..26, 12)
    self.agregarFila(10..17, 11)
    self.agregarFila(23..25, 10)
    self.agregarFila(3..7, 9)
    self.agregarFila(30..31, 6)
    self.agregarFila(6..18, 4)
    self.agregarFila(20..25, 4)
    self.agregarFila(28..30, 4)

    // paredes verticales internas del laberinto
    self.agregarColumna(4, 18..21)
    self.agregarColumna(7, 10..12)
    self.agregarColumna(8, 14..15)
    self.agregarColumna(13, 15..16)
    self.agregarColumna(16, 12..13)
    self.agregarColumna(17, 15..16)
    self.agregarColumna(20, 5..10)
    self.agregarColumna(23, 15..19)

    // paredes individuales
    self.agregarPared(6, 1)
    self.agregarPared(25, 11)
    self.agregarPared(30, 5)
    self.agregarPared(31, 7)
    self.agregarPared(30, 8)
  }
}