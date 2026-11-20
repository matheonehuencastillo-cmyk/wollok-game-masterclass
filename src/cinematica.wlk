import wollok.game.*
import pantallas.*

object cinematica {
    const imagenes = ["cinematica1.png", "cinematica2.png", "cinematica3.png", "cinematica4.png"]
    var indiceActual = 0
    
    var property position = game.at(0, 0)

    method image() = imagenes.get(indiceActual)

    method iniciar() {
        indiceActual = 0
        game.addVisual(self)
        keyboard.f().onPressDo({ self.avanzar() })
    }

    method avanzar() {
        indiceActual = indiceActual + 1
        if (self.esElFinal()) {
            self.finalizar()
        }
    }

    method esElFinal() = indiceActual >= imagenes.size()

    method finalizar() {
        game.removeVisual(self)
        inicio.mostrarMenu()
    }
}