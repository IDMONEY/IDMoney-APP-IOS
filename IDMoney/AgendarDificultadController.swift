//
//  AgendarDificultadController.swift
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

class AgendarDificultadController: UIViewController {
    @IBOutlet weak var Check1: UIImageView!
    @IBOutlet weak var Check2: UIImageView!
    @IBOutlet weak var Check3: UIImageView!
    @IBOutlet weak var Check4: UIImageView!
    @IBOutlet weak var Check5: UIImageView!
    @IBOutlet weak var Check6: UIImageView!
    @IBOutlet weak var Check7: UIImageView!
    @IBOutlet weak var Check8: UIImageView!

    
    @IBOutlet weak var btnDificultad11: UIButton!
    @IBOutlet weak var btnDificultad12: UIButton!
    @IBOutlet weak var btnCargaLiviana21: UIButton!
    @IBOutlet weak var btnCargaLiviana22: UIButton!
    @IBOutlet weak var brnCargaLiviana31: UIButton!
    @IBOutlet weak var brnCargaLiviana32: UIButton!
    @IBOutlet weak var btnDificultad41: UIButton!
    @IBOutlet weak var btnDificultad42: UIButton!
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "es_CR")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Hecho", style: UIBarButtonItemStyle.done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        
        
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
    
    
    }
    
    func createTimePicker() {
        
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "es_CR")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Hecho", style: UIBarButtonItemStyle.done, target: nil, action: #selector(donePressed2))
        toolbar.setItems([doneButton], animated: false)
        
        txtTime.inputAccessoryView = toolbar
        txtTime.inputView = timePicker
        
        
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "es_CR")
        
        txtDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func donePressed2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        txtTime.text = dateFormatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Check1.isHidden = true
        Check2.isHidden = true
        Check3.isHidden = true
        Check4.isHidden = true
        Check5.isHidden = true
        Check6.isHidden = true
        Check7.isHidden = true
        Check8.isHidden = true
        
        createDatePicker()
        createTimePicker()
        
        self.navigationItem.backBarButtonItem?.title = "Atras";

    }
    
    
    
    

    
    
    @IBAction func btnDificultad11Inside(_ sender: UIButton) {
        Check1.isHidden = false
        Check3.isHidden = true
        Check5.isHidden = true
        Check7.isHidden = true
        StructData.OrigenHouse = 1
        
    }
    
    @IBAction func btnDificultad12Inside(_ sender: UIButton) {
        
        Check2.isHidden = false
        Check4.isHidden = true
        Check6.isHidden = true
        Check8.isHidden = true
        StructData.DestinoHouse = 1
    }
    
    @IBAction func btnDificultad21Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check3.isHidden = false
        Check5.isHidden = true
        Check7.isHidden = true
        StructData.OrigenHouse = 2
    }
    
    @IBAction func btnDificultad22Inside(_ sender: UIButton) {
        Check2.isHidden = true
        Check4.isHidden = false
        Check6.isHidden = true
        Check8.isHidden = true
        StructData.DestinoHouse = 3
    }
    
    @IBAction func btnDificultad31Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check3.isHidden = true
        Check5.isHidden = false
        Check7.isHidden = true
        StructData.OrigenHouse = 3
    }
    
    @IBAction func btnDificultad32Inside(_ sender: UIButton) {
        Check2.isHidden = true
        Check4.isHidden = true
        Check6.isHidden = false
        Check8.isHidden = true
        StructData.DestinoHouse = 3
    }
    
    @IBAction func btnDificultad41Inside(_ sender: UIButton) {
        Check1.isHidden = true
        Check3.isHidden = true
        Check5.isHidden = true
        Check7.isHidden = false
        StructData.OrigenHouse = 4
    }
    
    @IBAction func btnDificultad42Inside(_ sender: UIButton) {
        Check2.isHidden = true
        Check4.isHidden = true
        Check6.isHidden = true
        Check8.isHidden = false
        StructData.DestinoHouse = 4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SeleccionarDestinoInside(_ sender: UIButton) {
       
        
        
        var myAlert = UIAlertController( title:"Falta Información", message: "Debe Seleccionar un Vehículo", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            print("ok")
        }
        
        
        
        
        
        if (StructData.OrigenHouse == 0){
            
                myAlert = UIAlertController( title:"Falta Información", message: "Debe seleccionar un origen", preferredStyle: UIAlertControllerStyle.alert)
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
            
            
            
        }
        
        if (StructData.DestinoHouse == 0){
            
            myAlert = UIAlertController( title:"Falta Información", message: "Debe seleccionar un destino", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
            
        }
        
        if txtDate.text == ""{
            myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger una fecha", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        
        if txtTime.text == ""{
            myAlert = UIAlertController( title:"Falta Información", message: "Debe escoger una hora", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }


    }
    
}
