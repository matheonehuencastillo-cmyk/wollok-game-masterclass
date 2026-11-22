import jugador.*

object hudVidas{
    method image() {
        return "corazon" + personaje.vidas().toString() + ".png"
    }

    method position() {
        return game.at(22, 24)
    }
}