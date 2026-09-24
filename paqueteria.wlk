/** First Wollok example */
object empresa{
	var property mensajeros = []
	var property paquetesPendientes = []
	var property paquetesEnviados = []
	var property facturacion = 0 

	method contratarMensajero(nombreMensajero){
		mensajeros.add(nombreMensajero)
	}

	method despedirMensajero(nombreMensajero) {
		mensajeros.remove(nombreMensajero)
	}

	method despedirTodosLosMensajeros() {
		mensajeros.clear()
	}

	method tieneEmpleado(nombreMensajero) {
	    return mensajeros.contains(nombreMensajero)
	}

	method empresaGrande(){
		return mensajeros.size() >= 2
	}

	method primerMensajeroDisponible(destinoAsignado){
		return paquete.puedeSerEntregadoPor_En_(mensajeros.first(), destinoAsignado)
	}

	method pesoDelUltimoMensajero() {
		return mensajeros.last().peso()
	}

	method sobrepesoMensajeria(){
		var peso = 0
		mensajeros.forEach({mensajero => peso += mensajero.peso()})
		return peso > 500
	}

	//lista de mensajeros
	method losQuePuedenEnviar(paqueteAEntregar, lugarAEntregar) {
	  return mensajeros.filter({mensajero => paqueteAEntregar.puedeSerEntregadoPor_En_(mensajero, lugarAEntregar)})
	}
	//true o false
	method hayAlgunMensajeroQuePuedeEntregar(paqueteAEntregar, lugarAEntregar) {
	  return mensajeros.any({mensajero => paqueteAEntregar.puedeSerEntregadoPor_En_(mensajero, lugarAEntregar)})
	}
	//un mensajero o excepcion
	method elPrimeroQuePuedaEntregar(paqueteAEntregar, lugarAEntregar) {
	  return mensajeros.find({mensajero => paqueteAEntregar.puedeSerEntregadoPor_En_(mensajero, lugarAEntregar)})
	}

	method todosPuedenEnviar(paqueteAEntregar, lugarAEntregar){
		return mensajeros.all({mensajero => paqueteAEntregar.puedeSerEntregadoPor_En_(mensajero, lugarAEntregar)})
	}

	method algunMensajeroTieneSobrepeso() {
		return mensajeros.any({mensajero => mensajero.peso() > 500})
	}



	method enviar(paqueteAEnviar, destinoAEntregar){
		if (self.hayAlgunMensajeroQuePuedeEntregar(paqueteAEnviar, destinoAEntregar)){
			paquetesEnviados.add(paqueteAEnviar)
			paquetesPendientes.remove(paqueteAEnviar)
			facturacion += paqueteAEnviar.precio()

		}else{
			paquetesPendientes.add(paqueteAEnviar)
			self.error("No se cumplen las condiciones de envio")
		}
	}

	//TODO: Hacer lista de paquetesPendientes
	method elMasCaro(){
		return paquetesPendientes.max({paquete => paquete.precio()})
	}

	method facturacionActual() {
	  return paquetesEnviados.forEach({paquete => facturacion =+ paquete.precio()})
	}

	//TODO: Añadir methodo enviar
	method enviarTodos(coleccionDePaquetes, destinoAEntregar) {
	  coleccionDePaquetes.forEach({paquete => self.enviar(paquete, destinoAEntregar)})
	}

	method enviarMasCaroA_(destinoAEntregar){
		
		self.enviar(self.elMasCaro(), destinoAEntregar)
	}
}



object paquetonViajero {
	var property pagado = false
	var property precio = 0

	method pagar(creditosPagados) {
		if(creditosPagados >= precio){
			precio = 0
			pagado = true
		}
		else{
			precio = precio - creditosPagados
		}

	}

	method precioTotal(listaDeDestinoaPaquete){
		listaDeDestinoaPaquete.forEach({paquete => precio += 100})
	}

	method precioDestino(destinoaPaquete){
		return destinoaPaquete.precio()
	}

	method puedeSerEntregadoPor_En_(mensajeroDelPaquete, listaDeDestinoaPaquete) {
	  return pagado and listaDeDestinoaPaquete.forEach({destino => destino.condicionEntrada(mensajeroDelPaquete)})
	}

}

object paquetito {
	var property pagado = true
	var property precio = 0


	method precioDestino(destinoaPaquete){
		return destinoaPaquete.precio()
	}

	method puedeSerEntregadoPor_En_(mensajeroDelPaquete, destinoaPaquete) {
	  return destinoaPaquete.condicionEntrada(mensajeroDelPaquete)
	}

}

object paquete {
	var property pagado = false
	var property precio = 50


	method pagar(creditosPagados) {
		if(creditosPagados >= precio){
			precio = 0
			pagado = true
		}
		else{
			precio = precio - creditosPagados
		}

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
