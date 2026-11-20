import wollok.game.*
import pantallas.*
import jugador.*
import mapa.*


object salida {
  method position() = game.at(29, 23)
  method image() = "objetoSalida.png"

method colision() {
    inicio.nivelActual().alLlegarASalida()
  }
}