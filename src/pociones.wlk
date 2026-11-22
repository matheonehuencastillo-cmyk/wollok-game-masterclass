import jugador.*
import tiempo.*

//Clase que representa un elemento del juego, al momento de instanciar hay que indicar la ruta de la imagen y sonido.
class PocionVida {
    var property image
    var property position

    method colision() {
            game.say(personaje,"¡Una poción de vida!")
            personaje.sumarVida()
            game.removeVisual(self)
        }
}

class PocionTiempo inherits PocionVida {

    override method colision() {
            game.say(personaje,"¡Una poción de tiempo! +5 segundos")
            relojDePartida.sumarTiempo()
            game.removeVisual(self)
        }
}