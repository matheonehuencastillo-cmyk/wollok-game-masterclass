import wollok.game.*
import jugador.*
import tiempo.*

class PocionVida {
    var property image
    var property position
    var property sonido

    method colision() {
        game.sound(sonido).play()
        game.say(personaje, "¡Una poción de vida!")
        personaje.sumarVida()
        game.removeVisual(self)
    }
}

class PocionTiempo inherits PocionVida {
    override method colision() {
        game.sound(sonido).play()
        game.say(personaje, "¡Una poción de tiempo! +5 segundos")
        relojDePartida.sumarTiempo()
        game.removeVisual(self)
    }
}