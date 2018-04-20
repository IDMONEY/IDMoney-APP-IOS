//
//  TipoPagoEliminarController.swift
//  Trok
//
//  Created by Administrator on 3/1/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class TipoPagoEliminarController: UIViewController {
    
    @IBOutlet weak var txtNumeroTarjeta: UITextField!
    @IBOutlet weak var txtMesVencimiento: UITextField!
    @IBOutlet weak var txtYearVencimiento: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtNumeroTarjeta.text = StructData.Eliminar_NumeroTarjeta
        txtMesVencimiento.text = String(format: "%d", StructData.Eliminar_VencimientoMes)
        txtYearVencimiento.text = String(format: "%d", StructData.Eliminar_VencimientoYear)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnEliminarInside(_ sender: Any) {
        
        let wsApp = WS_Tokens()
        
        let registrar = Req_RegistrarTipoPago()
        
        registrar.idCliente = StructData.Eliminar_IdTipoPago
        
        let res = wsApp.Trok_EliminarTipoPago(req: registrar)
        
        
        let result = wsApp.Trok_ObtenerTipoPagoCliente(req: registrar)
        
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "A")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
}

