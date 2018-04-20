//
//  RegistrarUsuarioController.swift
//  Trok
//
//  Created by Administrator on 2/10/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit



class RegistrarUsuarioController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtIdentificacion: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var photo: UIImageView!
    
    var imagenFoto: UIImage!
    
    
    var  base64String2:String = ""
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        photo.layer.cornerRadius = photo.frame.size.width/2
//        photo.clipsToBounds = true
        
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .camera
//        imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.rear
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func TakePicture(_ sender: Any) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func TakePictureInside(_ sender: Any) {
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        photo.contentMode = .scaleAspectFit
        photo.image = chosenImage
        imagenFoto = chosenImage!
        base64String2 = (UIImagePNGRepresentation(chosenImage!)?.base64EncodedString(options: .init(rawValue: 0)))!
        
        UIImageWriteToSavedPhotosAlbum(imagenFoto, nil, nil, nil)
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func RegistroInside(_ sender: UIButton) {
        
        
        
        var save:Bool = true
        
        var myAlert = UIAlertController( title:"Falta Información", message: "Debe Seleccionar un Vehículo", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
            print("ok")
        }
        
        
        
        
        
        if (txtNombre.text == "" || txtApellidos.text == "" || txtIdentificacion.text == "" || txtTelefono.text == "" || txtCorreo.text == ""){
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Todos los datos son requeridos", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
        }
        
        if (photo.image == nil){
            save = false
            myAlert = UIAlertController( title:"Falta Información", message: "Debe tomarse una foto", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            
            
        }
        
        
        if save == true {
            
            
            
            
            
            let wsApp = WS_Tokens()
            
            
//            let registrar2 = Req_RegistrarUsuario2()
//            
//            registrar2.usuario.idCliente = 0
//            registrar2.usuario.nombre = txtNombre.text!
//            registrar2.usuario.apellido1 = txtApellidos.text!
//            registrar2.usuario.apellido2 = base64String!
//            registrar2.usuario.correo = txtCorreo.text!
//            registrar2.usuario.identificacion = txtIdentificacion.text!
//            registrar2.usuario.telefono = txtTelefono.text!
//            registrar2.usuario.password = "123"
//            registrar2.usuario.estado = "A"
//            registrar2.usuario.login = txtCorreo.text!
//
//            let res2 = wsApp.Trok_RegistrarUsuario2(req: registrar2)
            
            
            
            let v = UIView(frame: self.view.bounds)
            v.backgroundColor = UIColor.lightGray
            v.alpha = 1
            
            self.view.addSubview(v)
            UIView.animate(withDuration: 1, animations: {
                v.alpha = 0.0
            }, completion: {(finished:Bool) in
                //println("inside")
                v.removeFromSuperview()
            })
            
            
            UIGraphicsBeginImageContext(self.view.frame.size)
            
            
            
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)

            base64String2 = (UIImagePNGRepresentation(image!)?.base64EncodedString(options: .init(rawValue: 0)))!
            
            let registrar = Req_RegistrarUsuario()
            
            registrar.usuario.idCliente = 0
            registrar.usuario.nombre = txtNombre.text!
            registrar.usuario.apellido1 = txtApellidos.text!
            registrar.usuario.apellido2 = ""
            registrar.usuario.correo = txtCorreo.text!
            registrar.usuario.identificacion = txtIdentificacion.text!
            registrar.usuario.telefono = txtTelefono.text!
            registrar.usuario.password = "123"
            registrar.usuario.estado = "A"
            registrar.usuario.login = txtCorreo.text!
            registrar.usuario.foto = base64String2
            
            //print(base64String)
            
            
            let res = wsApp.Trok_RegistrarUsuario(req: registrar)
            
            
            var i:Int = 0
//
            
            
       
        }
        
        

    }
    
    
}



//class RegistrarUsuarioController: UIViewController {
//    
//    var imagePicker: UIImagePickerController
//    
//    @IBOutlet weak var photo: UIImageView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func TakePictureInside(_ sender: Any) {
//        
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
//        
//        
//        present(imagePicker, animated: true, completion: nil)
//        
//    
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        imagePicker.dismiss(animated: true, completion: nil)
//        photo.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//    }
////
//
//    
//}
