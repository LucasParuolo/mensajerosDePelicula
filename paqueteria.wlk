/** First Wollok example */
object paquete {
	var property destino = "matrix"
	var property pagado = false
	var property mensajero = "jeanGray"

	method pagar() {
		pagado = true
	}

	method precioDestino(){
		return destino.precio()
	}

	method entrega() {
	  return pagado and destino.condicionEntrada(mensajero)
	}
}

object matrix {
	method precio() {
	  return 500
	}

	method condicionEntrada(mensajeroActual){
		return mensajeroActual.puedeLlamar()
	}
}

object brooklyn  {
	method precio() {
	  return 150
	}

	method condicionEntrada(mensajeroActual){
	  return mensajeroActual.peso() < 1000
	}
}

object jeanGray {
	method puedeLlamar() {
	  return true
	}

  	method peso(){
		return 65
  	}
}

object neo {
	var property credito = true

	method puedeLlamar() {
	  return credito
	}

  	method peso(){
		return 0
  	}
}

object saraConnor {
	var property vehiculo = "moto"
	var property pesoS = 0 
	

	method puedeLlamar() {
	  return false
	}

  	method peso(){
		return vehiculo.pesoVehiculo(pesoS)
  	}
}

object moto {
  method pesoVehiculo(pesoUsuario) {
	return pesoUsuario + 100
  }
}

object camion {
	var property acoprados = 0 
  method pesoVehiculo(pesoUsuario) {
	return pesoUsuario + (500 + (500 * acoprados))
  }
}
