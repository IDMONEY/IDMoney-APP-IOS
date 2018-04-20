//
//  AngendarTipoVehiculoController.swift
//  Trok
//
//  Created by Administrator on 22/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation

//
//  ViewController.swift
//  Trok
//
//  Created by Administrator on 11/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit

class AgendarTipoVehiculoController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnTipoMaterial4000: DropMenuButton!
    
    @IBOutlet weak var btnTipoMaterial6000: DropMenuButton!

    @IBOutlet weak var btnTipoMaterial8000: DropMenuButton!

    @IBOutlet weak var btnTipoMaterial10000: DropMenuButton!

    @IBOutlet weak var btnTipoRemolque: DropMenuButton!

    @IBOutlet weak var btnTipoAmbulancia: DropMenuButton!
    
    @IBOutlet weak var btnTipoSoporte: DropMenuButton!

    
    @IBOutlet weak var View4000: UIView!
    

    @IBOutlet weak var View6000: UIView!
    @IBOutlet weak var View8000: UIView!
    @IBOutlet weak var View10000: UIView!
    @IBOutlet weak var ViewGrua: UIView!
    @IBOutlet weak var ViewAmbulancia: UIView!
    
    @IBOutlet weak var ViewPrincipal: UIView!
    
    
    
    @IBOutlet weak var Check6: UIImageView!
    @IBOutlet weak var Check5: UIImageView!
    @IBOutlet weak var Check4: UIImageView!
    @IBOutlet weak var Check3: UIImageView!
    @IBOutlet weak var Check2: UIImageView!
    @IBOutlet weak var Check1: UIImageView!
    
    @IBOutlet weak var btnCargaLiviana1: UIButton!
    
    @IBOutlet weak var btnCargaLiviana4: UIButton!
    @IBOutlet weak var brnCargaLiviana3: UIButton!
    @IBOutlet weak var btnCargaLiviana2: UIButton!
    @IBOutlet weak var btnCargaLiviana5: UIButton!
    @IBOutlet weak var btnCargaLiviana6: UIButton!
    
    
    
    
    @IBOutlet weak var txtDetalle1500: UITextView!
    
    @IBOutlet weak var txtRemolque: UITextView!
   
    @IBOutlet weak var txtDetalle2000: UITextView!
    @IBOutlet weak var txtDetalle12000: UITextView!
    @IBOutlet weak var txtDetalle50000: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = "Atrás";
        
        txtDetalle1500.delegate = self
        txtDetalle2000.delegate = self
        txtDetalle12000.delegate = self
        txtDetalle50000.delegate = self
        txtRemolque.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        Check6.isHidden = true
        Check5.isHidden = true
        Check4.isHidden = true
        Check3.isHidden = true
        Check2.isHidden = true
        Check1.isHidden = true
        
        ViewPrincipal.isHidden = false
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        
        btnTipoMaterial4000.initMenu(["A - General", "B - Granel", "C - Peligrosa","D - Perecedera","E - Frágil","F - Otra"], actions: [({ () -> (Void) in
            StructData.TipoMaterial = 1
            StructData.TipoMaterial1500 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 2
            StructData.TipoMaterial1500 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 3
            StructData.TipoMaterial1500 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 4
            StructData.TipoMaterial1500 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 5
            StructData.TipoMaterial1500 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 6
            StructData.TipoMaterial1500 = true
        })])
        
        btnTipoMaterial6000.initMenu(["A - General", "B - Granel", "C - Peligrosa","D - Perecedera","E - Frágil","F - Otra"], actions: [({ () -> (Void) in
            StructData.TipoMaterial = 1
            StructData.TipoMaterial2000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 2
            StructData.TipoMaterial2000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 3
            StructData.TipoMaterial2000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 4
            StructData.TipoMaterial2000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 5
            StructData.TipoMaterial2000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 6
            StructData.TipoMaterial2000 = true
        })])
        
        btnTipoMaterial8000.initMenu(["A - General", "B - Granel", "C - Peligrosa","D - Perecedera","E - Frágil","F - Otra"], actions: [({ () -> (Void) in
            StructData.TipoMaterial = 1
            StructData.TipoMaterial12000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 2
            StructData.TipoMaterial12000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 3
            StructData.TipoMaterial12000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 4
            StructData.TipoMaterial12000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 5
            StructData.TipoMaterial12000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 6
            StructData.TipoMaterial12000 = true
        })])
        
        btnTipoMaterial10000.initMenu(["A - General", "B - Granel", "C - Peligrosa","D - Perecedera","E - Frágil","F - Otra"], actions: [({ () -> (Void) in
            StructData.TipoMaterial = 1
            StructData.TipoMaterial50000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 2
            StructData.TipoMaterial50000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 3
            StructData.TipoMaterial50000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 4
            StructData.TipoMaterial50000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 5
            StructData.TipoMaterial50000 = true
        }), ({ () -> (Void) in
            StructData.TipoMaterial = 6
            StructData.TipoMaterial50000 = true
        })])
        
        btnTipoRemolque.initMenu(["A - Remolque Liviano", "B - Plataforma Liviana", "C - Remolque Pesado","D - Plataforma Pesada"], actions: [({ () -> (Void) in
            StructData.TipoRemolque = 1
        }), ({ () -> (Void) in
            StructData.TipoRemolque = 2
        }), ({ () -> (Void) in
            StructData.TipoRemolque = 3
        }), ({ () -> (Void) in
            StructData.TipoRemolque = 4
        })])
        
        btnTipoAmbulancia.initMenu(["A - Personas", "B - Mascotas"], actions: [({ () -> (Void) in
            StructData.TipoAmbulancia = 1
        }), ({ () -> (Void) in
            StructData.TipoAmbulancia = 2
        })])
        
        
        btnTipoSoporte.initMenu(["A - Soporte básico", "B - Soporte Avanzado", "C - Traslado"], actions: [({ () -> (Void) in
            StructData.TipoSoporte = 1
        }), ({ () -> (Void) in
            StructData.TipoSoporte = 2
        }), ({ () -> (Void) in
            StructData.TipoSoporte = 3
        })])
        
    }
    
    
    @IBAction func btnCargaLiviana1Inside(_ sender: UIButton) {
        Check1.isHidden = false
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View4000.isHidden = false
        
        StructData.vehiculo = 1
    }
    
    @IBAction func btnCargaLiviana2Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = false
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View6000.isHidden = false
        StructData.vehiculo = 3
    }
    
    @IBAction func btnCargaLiviana3Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = false
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View8000.isHidden = false
        StructData.vehiculo = 4
    }
    
    @IBAction func btnCargaLiviana4Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = false
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View10000.isHidden = false
        StructData.vehiculo = 5
    }
    
    @IBAction func btnCargaLiviana5Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = false
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        ViewGrua.isHidden = false
        StructData.vehiculo = 6
    }
    
    @IBAction func btnCargaLiviana6Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = false
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        ViewAmbulancia.isHidden = false
        StructData.vehiculo = 7
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func btnCargaLiviana1PInside(_ sender: UIButton) {
        Check1.isHidden = false
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View4000.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 1
        
    }
    
    @IBAction func btnCargaLiviana11PInside(_ sender: UIButton) {
        Check1.isHidden = false
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View4000.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 2
    }

    
    @IBAction func btnCargaLiviana2PInside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = false
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View6000.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 3
    }
    
    @IBAction func btnCargaLiviana3PInside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = false
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View8000.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 4
    }
    
    @IBAction func btnCargaLiviana4PInside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = false
        Check5.isHidden = true
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        View10000.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 5
    }
    
    @IBAction func btnCargaLiviana5PInside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = false
        Check6.isHidden = true
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        ViewGrua.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 6
    }
    
    @IBAction func btnCargaLiviana6PInside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = false
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        ViewAmbulancia.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 7
    }
    
    @IBAction func btnCargaLiviana7PInside(_ sender: UIButton) {
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = false
        
        View4000.isHidden = true
        View6000.isHidden = true
        View8000.isHidden = true
        View10000.isHidden = true
        ViewGrua.isHidden = true
        ViewAmbulancia.isHidden = true
        
        ViewAmbulancia.isHidden = false
        ViewPrincipal.isHidden = true
        StructData.vehiculo = 8
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            txtDetalle1500.resignFirstResponder()
            txtDetalle2000.resignFirstResponder()
            txtDetalle12000.resignFirstResponder()
            txtDetalle50000.resignFirstResponder()
            txtRemolque.resignFirstResponder()
        }
        return true
    }
    
    
    
    @IBAction func btnSiguienteInside(_ sender: UIButton) {
        
        var myAlert = UIAlertController( title:"Falta Información", message: "Debe Seleccionar un Vehículo", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            print("ok")
        }
        
        

        
        if (StructData.vehiculo == 0){
            self.present(myAlert, animated: true, completion: nil)
        }
        
        if (StructData.vehiculo == 1){
            if txtDetalle1500.text == ""{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe agregar el detalle", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            
            if StructData.TipoMaterial == 0 || StructData.TipoMaterial1500 == false{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de material", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            
        }
        
        if (StructData.vehiculo == 2){
            if txtDetalle2000.text == ""{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe agregar el detalle", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            if StructData.TipoMaterial == 0 {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de material", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }

        }
        
        if (StructData.vehiculo == 3){
            if txtDetalle2000.text == ""{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe agregar el detalle", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            if StructData.TipoMaterial == 0 || StructData.TipoMaterial2000 == false {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de material", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }

        }
        
        if (StructData.vehiculo == 4){
            if txtDetalle12000.text == ""{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe agregar el detalle", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            if StructData.TipoMaterial == 0 || StructData.TipoMaterial12000 == false {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de material", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }

        }
        
        if (StructData.vehiculo == 5){
            if txtDetalle50000.text == ""{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe agregar el detalle", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            if StructData.TipoMaterial == 0 || StructData.TipoMaterial50000 == false {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de material", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
        }
        
        if (StructData.vehiculo == 6){
            
            if txtRemolque.text == ""{
                myAlert = UIAlertController( title:"Falta Información", message: "Debe agregar el detalle", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            if StructData.TipoRemolque == 0  {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de remolque", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }

        }
        
        if (StructData.vehiculo == 7){
            
            if StructData.TipoAmbulancia == 0  {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de ambulancia", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
            
            if StructData.TipoSoporte == 0  {
                myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger el tipo de soporte", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            }
        }
        
        if (StructData.vehiculo == 8){
            self.present(myAlert, animated: true, completion: nil)
        }
        

    }

    
}
