import Foundation
public class Req_CalcularViaje:Request_Base{
     public var tipoCamion : Int = 0
     public var kilometros : Double = 0
     public var tiempoCarga : Double = 0
     public var tiempoDescarga : Double = 0
     public var tiempoTrayectoConMovimiento : Double = 0
     public var tiempoTrayectoSinMovimiento : Double = 0
     public var peso : Double = 0
     public var dificultadCarga : Double = 0
     public var dificultadDescarga : Double = 0
     public var Seguro : Double = 0
     public var Ayudantes : Int = 0
}
