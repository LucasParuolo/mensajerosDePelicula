/** First Wollok example */
object paquete {
	var property pagado = false

	method pagar() {
		pagado = true
	}

	method precioDestino(destinoaPaquete){
		return destinoaPaquete.precio()
	}

	method puedeSerEntregadoPor_En_(mensajeroDelPaquete, destinoaPaquete) {
	  return pagado and destinoaPaquete.condicionEntrada(mensajeroDelPaquete)
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
	var property vehiculo = moto
	var property pesoActualDeSara = 0 
	

	method puedeLlamar() {
	  return false
	}

  	method peso(){
		return pesoActualDeSara + vehiculo.pesoVehiculo()
  	}
}

object moto {
  method pesoVehiculo() {
	return 100
  }
}

object camion {
	var property acoprados = 0 
  method pesoVehiculo() {
	return (500 + (500 * acoprados))
  }
}
