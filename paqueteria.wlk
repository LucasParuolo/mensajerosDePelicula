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
		return Paquete.puedeSerEntregadoPor_(mensajeros.first())
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
	method losQuePuedenEnviar(paqueteAEntregar) {
	  return mensajeros.filter({mensajero => paqueteAEntregar.puedeSerEntregadoPor_(mensajero)})
	}
	//true o false
	method hayAlgunMensajeroQuePuedeEntregar(paqueteAEntregar) {
	  return mensajeros.any({mensajero => paqueteAEntregar.puedeSerEntregadoPor_(mensajero)})
	}
	//un mensajero o excepcion
	method elPrimeroQuePuedaEntregar(paqueteAEntregar) {
	  return mensajeros.find({mensajero => paqueteAEntregar.puedeSerEntregadoPor_(mensajero)})
	}

	method todosPuedenEnviar(paqueteAEntregar){
		return mensajeros.all({mensajero => paqueteAEntregar.puedeSerEntregadoPor_(mensajero)})
	}

	method algunMensajeroTieneSobrepeso() {
		return mensajeros.any({mensajero => mensajero.peso() > 500})
	}



	method enviar(paqueteAEnviar){
		if (self.hayAlgunMensajeroQuePuedeEntregar(paqueteAEnviar)){
			paquetesEnviados.add(paqueteAEnviar)
			paquetesPendientes.remove(paqueteAEnviar)
			facturacion += paqueteAEnviar.precioOriginal()

		}else{
			paquetesPendientes.add(paqueteAEnviar)
		}
	}

	//TODO: Hacer lista de paquetesPendientes
	method elMasCaro(){
		return paquetesPendientes.max({paquete => paquete.precioOriginal()})
	}

	method facturacionActual() {
	  return facturacion
	}

	method cantidadPaquetesPendientes() {
	  return paquetesPendientes.size()
	}

	method cantidadPaquetesEnviados() {
	  return paquetesEnviados.size()
	}

	//TODO: Añadir methodo enviar
	method enviarTodos(coleccionDePaquetes) {
	  coleccionDePaquetes.forEach({paquete => self.enviar(paquete)})
	}

	method enviarMasCaro(){
		
		self.enviar(self.elMasCaro())
	}
}



class PaquetonViajero {
	var property pagado = false
	var property creditosAbonados = 0
	const property destinos = []

	method precioBase() {
		return destinos.size() * 100
	}

	method precio(){
		return (self.precioBase() - creditosAbonados).max(0)
	}

	method precioOriginal() {
		return self.precioBase()
	}

	method pagar(creditosPagados) {
		creditosAbonados += creditosPagados
		if (self.precio() == 0){
			pagado = true
		}

	}

	method precioDestino(destinoaPaquete){
		return destinoaPaquete.precio()
	}

	method puedeSerEntregadoPor_(mensajeroDelPaquete) {
	  return pagado and destinos.all({destino => destino.condicionEntrada(mensajeroDelPaquete)})
	}

}

class Paquetito {
	var property pagado = true
	var property precioBase = 0
	var property creditosAbonados = 0
	var property destino = ""

	method precioOriginal() {
		return precioBase
	}

	method precioDestino(){
		return destino.precio()
	}

	method puedeSerEntregadoPor_(mensajeroDelPaquete) {
	  return destino.condicionEntrada(mensajeroDelPaquete)
	}

}

class Paquete {
	var property pagado = false
	var property precioBase = 50
	var property creditosAbonados = 0
	var property destino = ""

	method precio(){
		return (precioBase - creditosAbonados).max(0)
	}

	method precioOriginal() {
		return precioBase
	}

	method pagar(creditosPagados) {
		creditosAbonados += creditosPagados
		if (self.precio() == 0){
			pagado = true
		}

	}

	method precioDestino(){
		return destino.precio()
	}

	method puedeSerEntregadoPor_(mensajeroDelPaquete) {
	  return pagado and destino.condicionEntrada(mensajeroDelPaquete)
	}

}

class PaqueteFragil {
	var property pagado = false
	var property precioBase = 75
	var property creditosAbonados = 0
	var property destino = ""

	method precio(){
		return (precioBase - creditosAbonados).max(0)
	}

	method precioOriginal() {
		return precioBase
	}

	method pagar(creditosPagados) {
		creditosAbonados += creditosPagados
		if (self.precio() == 0){
			pagado = true
		}

	}

	method precioDestino(){
		return destino.precio()
	}

	method puedeSerEntregadoPor_(mensajeroDelPaquete) {
	  return pagado and (mensajeroDelPaquete.peso() < 100) and destino.condicionEntrada(mensajeroDelPaquete)
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

object t900 {
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
