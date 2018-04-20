//
//  StructData.swift
//  Trok
//
//  Created by Administrator on 27/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import MapKit

struct StructData {
    
    
    //Valores que se deben almacenar fijos
    static var SourceLongitud:CLLocationDegrees?
    static var SourceLatitud:CLLocationDegrees?
    static var DestLongitud:CLLocationDegrees?
    static var DestLatitud:CLLocationDegrees?

    
    static var OrigenHouse:Int = 0
    static var DestinoHouse:Int = 0
    
    static var vehiculo:Int = 0

    static var TipoMaterial:Int = 0
    static var TipoRemolque:Int = 0
    static var TipoAmbulancia:Int = 0
    static var TipoSoporte:Int = 0
    static var TipoMaterial1500:Bool = false
    static var TipoMaterial2000:Bool = false
    static var TipoMaterial12000:Bool = false
    static var TipoMaterial50000:Bool = false
    
    
    // variables registro tipo de pago
    static var TarjetasRegistradas = [String]()
    static var Eliminar_NumeroTarjeta:String = ""
    static var Eliminar_VencimientoMes:Int = 0
    static var Eliminar_VencimientoYear:Int = 0
    static var Eliminar_IdTipoPago:String = ""
}
