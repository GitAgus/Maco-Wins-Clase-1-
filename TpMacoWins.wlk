/** First Wollok example */
object coeficienteT{
	const property coeficiente = 0.01
}

class Prenda {
	const property tipo
	var property estado
	var property precioBase
	const property descuento
	method precio(){
		if (estado == "Nueva"){
			return precioBase
		}
		else if (estado == "Promoción"){
			return precioBase - descuento
		}
		else{
			return precioBase / 2
		}
	}
}
	
class Saco inherits Prenda(tipo = 'Saco'){}
class Pantalon inherits Prenda(tipo = 'Pantalon'){}
class Camisa inherits Prenda(tipo = 'Camisa'){}

class Venta{
	const property prendas
	const property fechaDeVenta
	const property medioDePago
	const property cuotas
	method montoBase(){
			return (prendas.sum({prenda => prenda.precio()}))
	}
	method montoTotal(){
		if (medioDePago == 'Efectivo'){
			return self.montoBase()
		}
		else{
			return (self.montoBase() * cuotas * coeficienteT.coeficiente() + 0.01 * self.montoBase())
		}
	}
	method cantidad(){
		return prendas.size()
	}
}

class Ganancias{
	var property listaVentas
	method gananciaPorDia(fecha){
		const ventasDiarias = listaVentas.filter({venta => venta.fechaDeVenta() == fecha})
		return (ventasDiarias.sum({venta => venta.montoTotal()}))
	}
}

