import wollok.game.*
import mapa.*
import jugador.*

class Enemigo {
	var property position
	var property activo = true

	method image()

	method mover() {
		if (activo) {
			self.ejecutarRutinaMovimiento()
		}
	}

	method ejecutarRutinaMovimiento()

	method intentarMoverA(nuevaPosicion) {
		if (self.esPosicionValida(nuevaPosicion)) {
			position = nuevaPosicion
		} else {
			self.alChocarConPared()
		}
	}

	method esPosicionValida(pos) {
		const dentroDeLimites = pos.x().between(0, game.width() - 1) and pos.y().between(0, game.height() - 1)
		const estaBloqueada = !mapa.esPosicionLibre(pos)
		return dentroDeLimites and not estaBloqueada
	}

	method alChocarConPared() {}

	method colision() {
		self.atacar(personaje)
	}

	method atacar(unJugador) {
		if (activo) {
			unJugador.recibirDanio()
		}
	}

	method detener() {
		activo = false
		game.removeTickEvent("mover_" + self.identity())
	}

	method iniciarComportamiento(frecuenciaMs) {
		game.onTick(frecuenciaMs, "mover_" + self.identity(), { self.mover() })
	}
}

class Murcielago inherits Enemigo {
	var direccion = derecho

	override method image() = "murcielago" + direccion.sufijoImagen() + ".png"

	override method ejecutarRutinaMovimiento() {
		const nuevaPos = direccion.siguientePosicion(position)
		self.intentarMoverA(nuevaPos)
	}

	override method alChocarConPared() {
		direccion = direccion.opuesta()
	}
}

class Esqueleto inherits Enemigo {
	var property rangoPersecucion = 5
	var property objetivo = null
	var direccion = abajo

	override method image() = "esqueleto" + direccion.sufijoImagen() + ".png"

	override method ejecutarRutinaMovimiento() {
		if (self.puedeYDebePerseguir()) {
			self.perseguir(objetivo.position())
		} else {
			self.patrullarAleatorio()
		}
	}

	method puedeYDebePerseguir() = 
		objetivo != null and position.distance(objetivo.position()) <= rangoPersecucion

	method perseguir(posObjetivo) {
		const diffX = posObjetivo.x() - position.x()
		const diffY = posObjetivo.y() - position.y()

		if (diffX.abs() >= diffY.abs()) {
			direccion = if (diffX > 0) derecho else izquierdo
		} else {
			direccion = if (diffY > 0) arriba else abajo
		}

		self.intentarMoverA(direccion.siguientePosicion(position))
	}

	method patrullarAleatorio() {
		direccion = direcciones.aleatoria()
		self.intentarMoverA(direccion.siguientePosicion(position))
	}
	override method iniciarComportamiento(frecuenciaMs) {
		super(frecuenciaMs + 2337)
	}
}

object direcciones {
	method todas() = [derecho, izquierdo, arriba, abajo]
	method aleatoria() = self.todas().anyOne()
}

object derecho {
	method siguientePosicion(pos) = game.at(pos.x() + 1, pos.y())
	method opuesta() = izquierdo
	method sufijoImagen() = "-derecha"
}

object izquierdo {
	method siguientePosicion(pos) = game.at(pos.x() - 1, pos.y())
	method opuesta() = derecho
	method sufijoImagen() = "-izquierda"
}

object arriba {
	method siguientePosicion(pos) = game.at(pos.x(), pos.y() + 1)
	method opuesta() = abajo
	method sufijoImagen() = "-arriba"
}

object abajo {
	method siguientePosicion(pos) = (game.at(pos.x(), pos.y() - 1))
	method opuesta() = arriba
	method sufijoImagen() = ""
}