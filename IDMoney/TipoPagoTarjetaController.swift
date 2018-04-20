//
//  TipoPagoTarjetaController.swift
//  Trok
//
//  Created by Administrator on 14/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit

class TipoPagoTarjetaController: UIViewController {
    
    @IBOutlet weak var txtTarjeta: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtVencimientoMes: UITextField!
    @IBOutlet weak var txtVencimientoYear: UITextField!
    @IBOutlet weak var ViewTarjeta: UIView!
    @IBOutlet weak var txtCVV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ViewTarjeta.backgroundColor = UIColor.yellow.withAlphaComponent(0.4)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveInside(_ sender: Any) {
        
        
        var save:Bool = true
        
        var myAlert = UIAlertController( title:"Falta Información", message: "Debe Seleccionar un Vehículo", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            print("ok")
        }
        
        
        
        
        
        if (txtTarjeta.text == ""){
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Debe digitar su número de tarjeta", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
            
        }
        
        if (txtNombre.text == ""){
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Debe digitar su nombre", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
            
        }
        
        if txtVencimientoMes.text == ""{
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Debe digitar el mes de vecimiento de su tarjeta", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        
        if txtVencimientoYear.text == ""{
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Debe digitar el año de vencimiento de su tarjeta", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        if txtCVV.text == ""{
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Debe digitar el código de seguridad de su tarjeta", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }

        
        if save == true {
            let wsApp = WS_Tokens()
            
            let registrar = Req_RegistrarTipoPago()
            
            registrar.idCliente = "0"
            registrar.numeroTarjeta = txtTarjeta.text!
            registrar.nombreTitularTarjeta = txtNombre.text!
            registrar.vecimientoMes = txtVencimientoMes.text!
            registrar.vecimientoYear = txtVencimientoYear.text!
            registrar.CCV = txtCVV.text!
            
            let res = wsApp.Trok_RegistrarTipoPago(req: registrar)
            
            
            let result = wsApp.Trok_ObtenerTipoPagoCliente(req: registrar)
            
            
            StructData.TarjetasRegistradas.append(txtTarjeta.text!)
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: "A")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
        
    }
    
    
}

