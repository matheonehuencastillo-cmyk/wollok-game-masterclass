import wollok.game.*
import cinematica.*
import jugador.*
import arquetipos.*
import tiempo.*
import objetosAColisionar.*
import salida.*
import enemigos.*
import hud.*

class PistaMusical {
  const sonido
  var estado = pistaDetenida

  method reproducir() { estado.reproducir(self, sonido) }
  method detener() { estado.detener(self, sonido) }
  method cambiarEstado(nuevoEstado) { estado = nuevoEstado }
}

object pistaDetenida {
  method reproducir(pista, sonido) {
    sonido.volume(0.1)
    sonido.shouldLoop(true)
    sonido.play()
    pista.cambiarEstado(pistaReproduciendo)
  }

  method detener(pista, sonido) {}
}

object pistaReproduciendo {
  method reproducir(pista, sonido) {}

  method detener(pista, sonido) {
    sonido.stop()
    pista.cambiarEstado(pistaDetenida)
  }
}

class PantallaBase {
  var property position = game.at(0, 0)

  method mostrarEnPantalla() {
    game.addVisual(self)
  }
}

class PantallaAnimada inherits PantallaBase {
  const imagenes = []
  var indiceActual = 0

  method image() = imagenes.get(indiceActual)

  method mostrar(intervaloMs) {
    indiceActual = 0
    self.mostrarEnPantalla()
    game.onTick(intervaloMs, "anim_" + self.identity(), { self.siguienteImagen() })
  }

  method siguienteImagen()
}

class PantallaCiclica inherits PantallaAnimada {
  override method siguienteImagen() {
    indiceActual = (indiceActual + 1) % imagenes.size()
  }
}

class PantallaAnimadaFinita inherits PantallaAnimada {
  override method siguienteImagen() {
    indiceActual = (indiceActual + 1).min(imagenes.size() - 1)
  }
}

object fondoLaberinto inherits PantallaCiclica(
  imagenes = ["fondo_nivel1_1.jpg", "fondo_nivel1_2.jpg"]
) {}

object pantallaMenu inherits PantallaCiclica(
  imagenes = ["menu_image1.jpg", "menu_image2.jpg"]
) {}

object pantallaControles inherits PantallaCiclica(
  imagenes = ["controles_1.jpg", "controles_2.jpg"]
) {}

object pantallaInstruccionesJuego inherits PantallaCiclica(
  imagenes = ["instrucciones_1.jpg", "instrucciones_2.jpg"]
) {}

object pantallaVictoria inherits PantallaCiclica(
  imagenes = ["pantallaVictoria_1.jpg", "pantallaVictoria_2.jpg"]
) {
  method mostrarVictoria() {
    inicio.limpiarEscena()
    self.mostrar(600)
    keyboard.enter().onPressDo({ inicio.mostrarMenu() })
  }
}

object pantallaGameOver inherits PantallaAnimadaFinita(
  imagenes = ["gameover_1.jpg", "gameover_2.jpg", "gameover_3.jpg"]
) {
  method iniciarAnimacion() {
    inicio.limpiarEscena()
    self.mostrar(600)
    keyboard.enter().onPressDo({ inicio.mostrarMenu() })
  }
}

object pantallaSeleccionHeroe inherits PantallaBase {
  var property imagenActual = "pantallaSeleccionHeroe.jpg"
  var estado = seleccionHabilitada

  method image() = imagenActual
  method cambiarEstado(nuevoEstado) { estado = nuevoEstado }

  method iniciar() {
    imagenActual = "pantallaSeleccionHeroe.jpg"
    estado = seleccionHabilitada
    self.mostrarEnPantalla()
  }

  method seleccionar(imagenHeroe, arquetipo) {
    estado.seleccionar(self, imagenHeroe, arquetipo)
  }
}

object seleccionHabilitada {
  method seleccionar(pantalla, imagenHeroe, arquetipo) {
    pantalla.cambiarEstado(seleccionBloqueada)
    pantalla.imagenActual(imagenHeroe)
    personaje.elegirArquetipo(arquetipo)
    game.schedule(2000, { inicio.mostrarInstruccionesJuego() })
  }
}

object seleccionBloqueada {
  method seleccionar(pantalla, imagenHeroe, arquetipo) {}
}

object gestorEnemigosNivelDos {
  const activos = []

  method crearEnemigos() = [
    new Murcielago(position = game.at(15, 2)),
    new Murcielago(position = game.at(10, 13)),
    new Murcielago(position = game.at(18, 21)),
    new Esqueleto(position = game.at(10, 8), objetivo = personaje),
    new Esqueleto(position = game.at(26, 16), objetivo = personaje)
  ]

  method mostrar() {
    self.detenerTodos()
    activos.addAll(self.crearEnemigos())
    activos.forEach({ enemigo => game.addVisual(enemigo) })
    game.onTick(550, "moverEnemigos", {
      activos.forEach({ enemigo => enemigo.mover() })
    })
  }

  method detenerTodos() {
    activos.forEach({ enemigo => enemigo.activo(false) })
    activos.clear()
  }
}

class ReglaSalida {
  const condicion
  const accion

  method aplica() = condicion.apply()
  method ejecutar() { accion.ejecutar() }
}

object accionAvanzarNivel {
  method ejecutar() { inicio.nivelDos() }
}

object accionPedirLlave {
  method ejecutar() { game.say(personaje, "Necesito la llave") }
}

class Nivel {
  method iniciar() {
    inicio.prepararTableroBase()
    self.colocarObjetos()
  }

  method colocarObjetos()
  method alLlegarASalida()
}

object nivelUno inherits Nivel {
  const reglasSalida = [
    new ReglaSalida(condicion = { cofreColocado.tieneLaLlave() }, accion = accionAvanzarNivel),
    new ReglaSalida(condicion = { not cofreColocado.tieneLaLlave() }, accion = accionPedirLlave)
  ]

  override method colocarObjetos() {
    trampaColocada.mostrar()
    cofreColocado.mostrar()
  }

  override method alLlegarASalida() {
    reglasSalida.find({ regla => regla.aplica() }).ejecutar()
  }
}

object nivelDos inherits Nivel {
  override method colocarObjetos() {
    gestorEnemigosNivelDos.mostrar()
  }

  override method alLlegarASalida() {
    pantallaVictoria.mostrarVictoria()
  }
}

object inicio {
  const musicaLaberinto = new PistaMusical(sonido = game.sound("musicaLaberinto.mp3"))
  const musicaMenu = new PistaMusical(sonido = game.sound("musicaMenu.mp3"))
  var property nivelActual = nivelUno

  method iniciar() {
    cinematica.iniciar()
  }

  method limpiarEscena() {
    gestorEnemigosNivelDos.detenerTodos()
    musicaLaberinto.detener()
    musicaMenu.detener()
    game.clear()
  }

  method mostrarMenu() {
    self.limpiarEscena()
    musicaMenu.reproducir()
    pantallaMenu.mostrar(800)

    keyboard.j().onPressDo({ self.mostrarSeleccionHeroe() })
    keyboard.c().onPressDo({ self.mostrarControles() })
  }

  method mostrarControles() {
    self.limpiarEscena()
    pantallaControles.mostrar(800)
    keyboard.enter().onPressDo({ self.mostrarMenu() })
  }

  method mostrarSeleccionHeroe() {
    self.limpiarEscena()
    pantallaSeleccionHeroe.iniciar()

    keyboard.num1().onPressDo({
      pantallaSeleccionHeroe.seleccionar(
        "seleccionHeroe_exploradora.jpg",
        new ArquetipoPersonaje(image = "exploradora", vidasIniciales = 2, tiempoExtra = 30)
      )
    })

    keyboard.num2().onPressDo({
      pantallaSeleccionHeroe.seleccionar(
        "seleccionHeroe_ingenioso.jpg",
        new ArquetipoPersonaje(image = "ingenioso", tiempoTrampa = 45000)
      )
    })

    keyboard.num3().onPressDo({
      pantallaSeleccionHeroe.seleccionar(
        "seleccionHeroe_tanque.jpg",
        new ArquetipoPersonaje(image = "tanque", vidasIniciales = 3, tiempoExtra = -20)
      )
    })
  }

  method mostrarInstruccionesJuego() {
    self.limpiarEscena()
    pantallaInstruccionesJuego.mostrar(500)
    game.schedule(3000, { self.nivelUno() })
  }

  method prepararTableroBase() {
    self.limpiarEscena()
    musicaLaberinto.reproducir()
    fondoLaberinto.mostrar(1000)

    personaje.reiniciar()
    game.addVisual(relojDePartida)
    game.addVisual(timerTexto)
    game.addVisual(hudVidas)
    game.addVisual(salida)
    game.addVisual(personaje)

    relojDePartida.iniciarTemporizador()
    self.configurarControlesJugador()
    personaje.activarColisiones()
  }

  method configurarControlesJugador() {
    keyboard.up().onPressDo({ personaje.subir() })
    keyboard.down().onPressDo({ personaje.bajar() })
    keyboard.left().onPressDo({ personaje.izquierda() })
    keyboard.right().onPressDo({ personaje.derecha() })
  }

  method nivelUno() {
    nivelActual = nivelUno
    nivelUno.iniciar()
  }

  method nivelDos() {
    nivelActual = nivelDos
    nivelDos.iniciar()
  }
}