//
//  NerdAcademyQuizViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 22/4/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import RealmSwift

var realm = try! Realm()
var preguntas: Results<Pregunta>!
var preguntasContestada: Results<PreguntaContestada>!

class Pregunta: Object {
    dynamic var pregunta = ""
    dynamic var RespuestaCorrecta = ""
    dynamic var IDRespuesta = ""
    dynamic var Respuesta1 = ""
    dynamic var Respuesta2 = ""
    dynamic var Respuesta3 = ""
    dynamic var Respuesta4 = ""
}

class PreguntaContestada: Object{
    dynamic var preguntaContestada = ""
    dynamic var preguntaContestadaID = ""
    dynamic var preguntaCorrecta = false
    
}

class NerdAcademyQuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewPreguntas: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPreguntas.register(UINib(nibName: "PreguntaTableViewCell", bundle: nil), forCellReuseIdentifier: "cellPreguntas")

        
        preguntas = realm.objects(Pregunta.self)
        preguntasContestada = realm.objects(PreguntaContestada.self)
        
        let pregunta1 = Pregunta()
        pregunta1.pregunta = "Cual de las siguientes afirmaciones sobre el control de plagas son correctas?"
        pregunta1.RespuestaCorrecta = "1"
        pregunta1.IDRespuesta = "1"
        pregunta1.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta1.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta1.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta1.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        let pregunta2 = Pregunta()
        pregunta2.pregunta = "Pregunta 1????"
        pregunta2.RespuestaCorrecta = "1"
        pregunta2.IDRespuesta = "2"
        pregunta2.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta2.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta2.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta2.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        
        let pregunta3 = Pregunta()
        pregunta3.pregunta = "Pregunta 2????"
        pregunta3.RespuestaCorrecta = "1"
        pregunta3.IDRespuesta = "3"
        pregunta3.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta3.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta3.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta3.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        
        let pregunta4 = Pregunta()
        pregunta4.pregunta = "Pregunta 3????"
        pregunta4.RespuestaCorrecta = "1"
        pregunta4.IDRespuesta = "4"
        pregunta4.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta4.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta4.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta4.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        let pregunta5 = Pregunta()
        pregunta5.pregunta = "Pregunta 4???? hoallslkdal"
        pregunta5.RespuestaCorrecta = "1"
        pregunta5.IDRespuesta = "5"
        pregunta5.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta5.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta5.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta5.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        let pregunta6 = Pregunta()
        pregunta5.pregunta = "Pregunta 6666666"
        pregunta5.RespuestaCorrecta = "1"
        pregunta5.IDRespuesta = "6"
        pregunta5.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta5.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta5.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta5.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        let pregunta7 = Pregunta()
        pregunta5.pregunta = "Pregunta 777777"
        pregunta5.RespuestaCorrecta = "1"
        pregunta5.IDRespuesta = "7"
        pregunta5.Respuesta1 = "Empresa de alimentos contar con programa de contra plagas"
        pregunta5.Respuesta2 = "una empresa que cuente con servicio externo para ekiminacion de plagas no necesita ocuparse del problema"
        pregunta5.Respuesta3 = "Las plagas solo pueden contaminar materias primas y no productos terminados"
        pregunta5.Respuesta4 = "Si la empresa cuenta con desague nunca se presentaran plagas"
        
        let lstPreguntas = List<Pregunta>()
        lstPreguntas.append(pregunta1)
        lstPreguntas.append(pregunta2)
        lstPreguntas.append(pregunta3)
        lstPreguntas.append(pregunta4)
        lstPreguntas.append(pregunta5)
        lstPreguntas.append(pregunta6)
        lstPreguntas.append(pregunta7)
        
        do {
            try realm.write {
                if preguntas.count <= 0{
                    for itemPregunta in lstPreguntas{
                        CargarPreguntas(itemPregunta)
                    }
                }else{
                    let lstAgregar = List<Pregunta>()
                    for itemPregunta in lstPreguntas{
                        for select in preguntasContestada{
                            if itemPregunta.IDRespuesta != select.preguntaContestadaID{
                                let objectsToDelete = preguntasContestada.filter("preguntaContestadaID = %@", itemPregunta.IDRespuesta)
                                if !objectsToDelete.isEmpty{
                                    lstAgregar.append(itemPregunta)
                                }                                
                            }else{
                                let objectsToDelete = realm.objects(Pregunta.self).filter("IDRespuesta = %@", itemPregunta.IDRespuesta)
                                realm.delete(objectsToDelete)
                            }
                        }
                    }
                    for pregunta in lstAgregar{
                        CargarPreguntas(pregunta)
                    }
                }
            }
        }catch {
            
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        tableViewPreguntas.reloadData()
        
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PreguntaTableViewCell = tableViewPreguntas.dequeueReusableCell(withIdentifier: "cellPreguntas", for: indexPath) as! PreguntaTableViewCell
        cell.cargarPregunta(pregunta: preguntas[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        cell.shouldSelectRow = indexPath
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCell:UITableViewCell = tableViewPreguntas.cellForRow(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.clear
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let selectedCell:UITableViewCell = tableViewPreguntas.cellForRow(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.clear
//    }
    
    //    MARK: - Metodos
    fileprivate func CargarPreguntas(_ itemPregunta: Pregunta) {
        let item = preguntas.filter{ $0.IDRespuesta.description == itemPregunta.IDRespuesta.description }
        if item.isEmpty
        {
            if !itemPregunta.IDRespuesta.isEmpty{
                let objectsNotAdd = preguntasContestada.filter("preguntaContestadaID = %@", itemPregunta.IDRespuesta)
                if objectsNotAdd.isEmpty{
                    realm.add(itemPregunta)
                }
            }
            
        }
    }
    
    fileprivate func PreguntaMarcada(_ pregunta: Pregunta) {
        do
        {
            try realm.write {
                let objectsToDelete = realm.objects(Pregunta.self).filter("IDRespuesta = %@", pregunta.IDRespuesta)
                realm.delete(objectsToDelete)
                tableViewPreguntas.reloadData()
            }
        }catch {
        }
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }
    }

    //    MARK: - Eventos
    
    //    MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func anadirPreguntasContestadas(preguntaContestada: Pregunta, identBoton : String){
        let idPregunta: String = preguntaContestada.IDRespuesta
        let respBuena: String = preguntaContestada.RespuestaCorrecta
        var respContestada: String = ""
        switch identBoton {
        case "1":
             respContestada = "1"
        case "2":
             respContestada = "2"
        case "3":
             respContestada = "3"
        case "4":
             respContestada = "4"
        default:
            respContestada = ""
        }
        
        
        do{
        try realm.write {
            let preguntaItem = preguntasContestada.filter{ $0.preguntaContestadaID.description == preguntaContestada.IDRespuesta }
            if preguntaItem.isEmpty
            {
                let preguntaCont = PreguntaContestada()
                preguntaCont.preguntaContestada = respContestada
                preguntaCont.preguntaContestadaID = idPregunta
                preguntaCont.preguntaCorrecta = respContestada == respBuena ? true : false
                realm.add(preguntaCont)
            }else{
                let alert = UIAlertController(title: "Alerta", message: "Esta pregunta ya fue contestada.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }

            }
        } catch {
        }
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }

    }
    
    func buscarPreguntaContestada(){
        
    }
}

//    MARK: - Extension cell delegate
extension NerdAcademyQuizViewController : PreguntaCellDelegate
{
    
    func didBtnRespuesta1(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 1")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "1")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta2(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 2")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "2")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta3(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 3")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "3")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta4(pregunta: Pregunta, indexSeleccionado: IndexPath) {
        NSLog("%@ buton%@", pregunta.pregunta, "btn 4")
        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "4")
        PreguntaMarcada(pregunta)
    }
    

    
    
}
