import game.*
import pantallas.*
import jugador.*

//visual de un reloj que acompaña al marco
object relojDePartida{
    method position() = game.at(game.width() - 21, game.height() - 3)
    const property image = "reloj-marco.png"
    var property tiempo = 45

    //metodo que inicia un temporizador el cual va a reducir el tiempo restante cada segundo.
    method iniciarTemporizador() {
        self.configurarTiempo()
        game.onTick(1000, "reducir tiempo partida", {
            self.reducirTiempo()
        })
    }

    //Metodo que configura el tiempo inicial de la partida sumando el tiempo extra del arquetipo del personaje.
    method configurarTiempo(){
        tiempo = 45 + personaje.arquetipo().tiempoExtra()
    }

    //metodo que reduce el valor de la variable tiempo en 5s
    method sumarTiempo(){
        tiempo = self.tiempo() + 5
    }

    //metodo que reduce el valor de la variable y si llega a 0 la reinicia e inicia la pantalla de game over.
    method reducirTiempo(){
        tiempo = (tiempo - 1).max(0)
        if (tiempo == 0){
            self.configurarTiempo()
            pantallaGameOver.iniciarAnimacion()
        }
    }
    
}
object relojDeInicio{
    method position() = game.at(game.width() - 21, game.height() - 3)
    const property image = "reloj-marco.png"
    var property tiempo = 3

    //metodo que inicia un temporizador el cual va a reducir el tiempo restante cada segundo.
    method iniciarTemporizador() {
        tiempo = 3
        game.onTick(1000, "reducir tiempo", {
            self.reducirTiempo()
        })
    }

    //metodo que reduce el valor de la variable y si llega a 0 la reinicia e inicia la pantalla de game over.
    method reducirTiempo(){
        tiempo = (tiempo - 1).max(0)
    }
    
}


//visual del timer del marco, indica el tiempo restante para completar el nivel.
object timerTexto {
    method position() = game.at(game.width() - 16, game.height() - 2)
    

    //Se coloca en el marco con reloj un texto que indica el tiempo restante en segundos.
    method text() = " " + relojDePartida.tiempo().toString() + " SEG..."

    //Este metodo asigna el color de la letra del timer.
    method textColor() = "#ffffff"
}

//visual del timer del marco, indica el tiempo restante para completar el nivel.
object timerTextoInicio {
    method position() = game.at(game.width() - 16, game.height() - 2)
    

    //Se coloca en el marco con reloj un texto que indica el tiempo restante en segundos.
    method text() = " " + relojDeInicio.tiempo().toString() + " SEG..."

    //Este metodo asigna el color de la letra del timer.
    method textColor() = "#ffffff"
}