import wollok.game.*

class ArquetipoPersonaje {
    const image = ""
    const vidasIniciales = 1
    const tiempoExtra = 0
    const tiempoTrampa = 3000
    const tiempoStun = 3000

    method personajeImagen() = image
    method vidasIniciales() = vidasIniciales
    method tiempoExtra() = tiempoExtra
    method tiempoTrampa() = tiempoTrampa
    method tiempoStun() = tiempoStun


    method iniciarReloj(reloj) {
        game.schedule(self.tiempoStun(), { reloj.iniciarTemporizador() })
    }
}






