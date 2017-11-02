class Minion{
	var rol
	var stamina = 10
	var tareas
	constructor(nuevoRol){
		rol = nuevoRol
	}
	method perderStamina(cant){
		if(stamina < cant){
			throw new Exception("No hay suficiente stamina")
		}	
	}
	method recargarStamina(fruta){
		stamina += fruta.staminaAportada()
	}
	method stamina() = stamina
	method rol() = rol
	method sumarTarea(tarea){tareas.add(tarea)}
	method experienca() = tareas.size() * tareas.sum({tarea => tarea.dificultad()})
	method fuerza()= (stamina / 2) + 2 + rol.fuerzaAportada() 
	method perderLaMitadDeLaStamina(){ self.perderStamina(stamina / 2)}
	method realizarTareaSiPuede(tarea){
		tarea.serRealizadaSiEsPosible(self)
		self.sumarTarea(tarea)
	}
	method tieneLasHerramientasNecesarias() = rol.tieneLasHerramientasNecesarias()
	method esSoldado() = rol.esSoldado()
	method puedeDefender() = rol.puedeDefender()
}


class Biclope inherits Minion{
	
	override method recargarStamina(fruta){
		stamina = 10.min(fruta.staminaAportada() + stamina)
	} 
	method fuerzaTotal() = self.fuerza()
	method modificadorAmenza() = 1
}

class Ciclope inherits Minion{
	method fuerzaTotal() = 0.5 * self.fuerza()
	method modificadorAmenaza() = 2
}
//-------------------------------------------------------Roles----------------------------------------------------------------------------------------------------
class Rol{
	var puedeDefender
	var esSoldado
	constructor(puede, esSol){puedeDefender = puede esSoldado = esSol}
	method puedeDefender() = puedeDefender
	method esSoldado() = esSoldado
	method tieneLasHerramientasNecesarias(herramientas) = herramientas.size() == 0
}

class Soldado inherits Rol{
	var practica = 0
	constructor() = super(true, true)
	method fuerzaAportada() = practica
	method sumarPractica(){practica +=2}
		
}

class Obrero inherits Rol{
	var herramientas = []
	constructor (listaHerramientas) = super(true, false) { herramientas = listaHerramientas}
	method fuerzaAportada() = 0
	override method tieneLasHerramientasNecesarias(listasHerramientas) = listaHerramientas.all({herramienta => herramientas.contains(herramienta)})

}
class Mucama inherits Rol{
	constructor() = super(false, false)
	method fuerzaAportadad() = 0
	
} 

//--------------------------------------------------------------------------------Tareas-------------------------------------------------------------------------



class ArreglarMaquina{
	var herramientas=[]
	var complejidad=0
	constructor(herr, comp){herramientas = herr complejidad = comp}
	method dificultad(empleado) = complejidad * 2
	method puedeSerRealizadaPor(empleado) = empleado.stamina() > complejidad && empleado.tieneLasHerramientasNecesarias(herramientas)
	method serRealizadaSiEsPosible(empleado){
		if(!self.puedeSerRealizadaPor(empleado)){
			throw new Exception("El empleado no puede realizar la tarea")
		}
		empleado.perderStamina(complejidad)
	}
}
class DefenderSector{
	var amenaza=0
	constructor(am){amenaza = am}
	method dificultad(empleado) = empleado.modificarAmenza() * amenaza
	method puedeSerRealizadaPor(empleado) = empleado.puedeDefender() && empleado.fuerzaTotal() > amenaza
	method serRealizadaSiEsPosible(empleado){
		
	}
		
}
class LimpiarSector{
	 var dificultad
	 var esGrande
	 constructor(dif, grande) {dificultad = dif esGrande = grande}
	 method staminaNecesaria(){
	 	if(esGrande){ return 4}
	 	else return 1
	 }
	 method dificultad(empleado) = dificultad
	 method puedeSerRealizadaPor(empleado){}
	}

//--------------------------------------------------------------------------------Frutas-------------------------------------------------------------------------
object banana{
	method staminaAportada() = 10
}
object manzana{
	method staminaAportada() = 5
}
object uva{
	method staminaAportada() = 1
}