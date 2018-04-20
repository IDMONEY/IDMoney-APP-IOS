//
//  TipoPagoRegistroController.swift
//  Trok
//
//  Created by Administrator on 22/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import Foundation

class TipoPagoRegistroController: UITableViewController {
    
    var tarjetas = [String]()
    var mes = [Int]()
    var year = [Int]()
    var id = [String]()
    //let list = ["Tarjeta Crédito", "Paypal"]
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StructData.TarjetasRegistradas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = StructData.TarjetasRegistradas[indexPath.row]
        
        return cell!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        let wsApp = WS_Tokens()
        
        let registrar = Req_RegistrarTipoPago()
        
        registrar.idCliente = "0"
        registrar.numeroTarjeta = "123456789"
        registrar.nombreTitularTarjeta = "Jairo Navarro"
        registrar.vecimientoMes = "01"
        registrar.vecimientoYear = "2020"
        registrar.CCV = "123"
        
        
        
        let result = wsApp.Trok_ObtenerTipoPagoCliente(req: registrar)
        StructData.TarjetasRegistradas.removeAll()
        
        
        
        if result.listaTipoPago.count > 0 {
            for tarjeta in result.listaTipoPago {
                
                StructData.TarjetasRegistradas.append(tarjeta.numeroTarjeta)
                tarjetas.append(tarjeta.numeroTarjeta)
                mes.append(tarjeta.vecimientoMes)
                year.append(tarjeta.vecimientoYear)
                id.append(tarjeta.idTipoPago)
            }
        
        }
        
//        StructData.TarjetasRegistradas = ["xxxx-xxxx-xxxx-8725", "xxxx-xxxx-xxxx-7896"]
//        identities = ["E", "B"]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        StructData.Eliminar_NumeroTarjeta = tarjetas[indexPath.row]
        StructData.Eliminar_VencimientoMes =  mes[indexPath.row]
        StructData.Eliminar_VencimientoYear = year[indexPath.row]
        StructData.Eliminar_IdTipoPago = id[indexPath.row]
        
        
        
        let vcName = "E"//identities[indexPath.row]
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        
        
        
        
    }
    
    
    
    
}
