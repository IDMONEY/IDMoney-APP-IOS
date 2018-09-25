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
var preguntasDescription = Array<PreguntaDescriptionLocalization>()
var preguntasContestada: Results<PreguntaContestada>!

class Pregunta: Object {
    //    dynamic var pregunta = ""
    dynamic var RespuestaCorrecta = ""
    dynamic var IDRespuesta = ""
    //    dynamic var Respuesta1 = ""
    //    dynamic var Respuesta2 = ""
    //    dynamic var Respuesta3 = ""
    //    dynamic var Respuesta4 = ""
}

class PreguntaDescriptionLocalization: Object{
    dynamic var IDRespuesta = "" //Id de referencia a la pregunta
    dynamic var pregunta = ""
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
        
        
        let lstPreguntas = CargarListaPreguntas()
        
        do {
            try realm.write {
                if preguntas.count <= 0{
                    for itemPregunta in lstPreguntas{
                        CargarPreguntas(itemPregunta)
                    }
                }else{
                    let lstAgregar = List<Pregunta>()
                    var i = 0
                    for itemPregunta in lstPreguntas{
                        for select in preguntasContestada{
                            i = i + 1
                            if itemPregunta.IDRespuesta != select.preguntaContestadaID{
                                let objectsToDelete = preguntasContestada.filter("preguntaContestadaID = %@", itemPregunta.IDRespuesta)
                                if !objectsToDelete.isEmpty{
                                    lstAgregar.append(itemPregunta)
                                }
                            }else{
                                let objectsToDelete = realm.objects(Pregunta.self).filter("IDRespuesta = %@", itemPregunta.IDRespuesta)
                                for des in preguntasDescription{
                                    if des.IDRespuesta == itemPregunta.IDRespuesta{
                                        if let index = preguntasDescription.index(of: des) {
                                            preguntasDescription.remove(at: index)
                                        }
                                    }
                                }
                                
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
        cell.cargarPregunta(pregunta: preguntasDescription[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        cell.shouldSelectRow = indexPath
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //    MARK: - Metodos
    func CargarListaPreguntas() -> List<Pregunta>{
        
        let pregunta1 = Pregunta()
        let preguntaDesc1 = PreguntaDescriptionLocalization()
        preguntaDesc1.pregunta = NSLocalizedString("pregunta1.pregunta", comment: "")
        pregunta1.RespuestaCorrecta = "4"
        pregunta1.IDRespuesta = "1"
        preguntaDesc1.IDRespuesta = "1"
        preguntaDesc1.Respuesta1 = NSLocalizedString("pregunta1.Respuesta1", comment: "")
        preguntaDesc1.Respuesta2 = NSLocalizedString("pregunta1.Respuesta2", comment: "")
        preguntaDesc1.Respuesta3 = NSLocalizedString("pregunta1.Respuesta3", comment: "")
        preguntaDesc1.Respuesta4 = NSLocalizedString("pregunta1.Respuesta4", comment: "")
        
        let pregunta2 = Pregunta()
        let preguntaDesc2 = PreguntaDescriptionLocalization()
        preguntaDesc2.pregunta = NSLocalizedString("pregunta2.pregunta", comment: "")
        pregunta2.RespuestaCorrecta = "4"
        pregunta2.IDRespuesta = "2"
        preguntaDesc2.IDRespuesta = "2"
        preguntaDesc2.Respuesta1 = NSLocalizedString("pregunta2.Respuesta1", comment: "")
        preguntaDesc2.Respuesta2 = NSLocalizedString("pregunta2.Respuesta2", comment: "")
        preguntaDesc2.Respuesta3 = NSLocalizedString("pregunta2.Respuesta3", comment: "")
        preguntaDesc2.Respuesta4 = NSLocalizedString("pregunta2.Respuesta4", comment: "")
        
        let pregunta3 = Pregunta()
        let preguntaDesc3 = PreguntaDescriptionLocalization()
        preguntaDesc3.pregunta = NSLocalizedString("pregunta3.pregunta", comment: "")
        pregunta3.RespuestaCorrecta = "4"
        pregunta3.IDRespuesta = "3"
        preguntaDesc3.IDRespuesta = "3"
        preguntaDesc3.Respuesta1 = NSLocalizedString("pregunta3.Respuesta1", comment: "")
        preguntaDesc3.Respuesta2 = NSLocalizedString("pregunta3.Respuesta2", comment: "")
        preguntaDesc3.Respuesta3 = NSLocalizedString("pregunta3.Respuesta3", comment: "")
        preguntaDesc3.Respuesta4 = NSLocalizedString("pregunta3.Respuesta4", comment: "")
        
        let pregunta4 = Pregunta()
        let preguntaDesc4 = PreguntaDescriptionLocalization()
        preguntaDesc4.pregunta = NSLocalizedString("pregunta4.pregunta", comment: "")
        pregunta4.RespuestaCorrecta = "4"
        pregunta4.IDRespuesta = "4"
        preguntaDesc4.IDRespuesta = "4"
        preguntaDesc4.Respuesta1 = NSLocalizedString("pregunta4.Respuesta1", comment: "")
        preguntaDesc4.Respuesta2 = NSLocalizedString("pregunta4.Respuesta2", comment: "")
        preguntaDesc4.Respuesta3 = NSLocalizedString("pregunta4.Respuesta3", comment: "")
        preguntaDesc4.Respuesta4 = NSLocalizedString("pregunta4.Respuesta4", comment: "")
        
        let pregunta5 = Pregunta()
        let preguntaDesc5 = PreguntaDescriptionLocalization()
        preguntaDesc5.pregunta = NSLocalizedString("pregunta5.pregunta", comment: "")
        pregunta5.RespuestaCorrecta = "4"
        pregunta5.IDRespuesta = "5"
        preguntaDesc5.IDRespuesta = "5"
        preguntaDesc5.Respuesta1 = NSLocalizedString("pregunta5.Respuesta1", comment: "")
        preguntaDesc5.Respuesta2 = NSLocalizedString("pregunta5.Respuesta2", comment: "")
        preguntaDesc5.Respuesta3 = NSLocalizedString("pregunta5.Respuesta3", comment: "")
        preguntaDesc5.Respuesta4 = NSLocalizedString("pregunta5.Respuesta4", comment: "")
        
        let pregunta6 = Pregunta()
        let preguntaDesc6 = PreguntaDescriptionLocalization()
        preguntaDesc6.pregunta = NSLocalizedString("pregunta6.pregunta", comment: "")
        pregunta6.RespuestaCorrecta = "4"
        pregunta6.IDRespuesta = "6"
        preguntaDesc6.IDRespuesta = "6"
        preguntaDesc6.Respuesta1 = NSLocalizedString("pregunta6.Respuesta1", comment: "")
        preguntaDesc6.Respuesta2 = NSLocalizedString("pregunta6.Respuesta2", comment: "")
        preguntaDesc6.Respuesta3 = NSLocalizedString("pregunta6.Respuesta3", comment: "")
        preguntaDesc6.Respuesta4 = NSLocalizedString("pregunta6.Respuesta4", comment: "")
        
        let pregunta7 = Pregunta()
        let preguntaDesc7 = PreguntaDescriptionLocalization()
        preguntaDesc7.pregunta = NSLocalizedString("pregunta7.pregunta", comment: "")
        pregunta7.RespuestaCorrecta = "4"
        pregunta7.IDRespuesta = "7"
        preguntaDesc7.IDRespuesta = "7"
        preguntaDesc7.Respuesta1 = NSLocalizedString("pregunta7.Respuesta1", comment: "")
        preguntaDesc7.Respuesta2 = NSLocalizedString("pregunta7.Respuesta2", comment: "")
        preguntaDesc7.Respuesta3 = NSLocalizedString("pregunta7.Respuesta3", comment: "")
        preguntaDesc7.Respuesta4 = NSLocalizedString("pregunta7.Respuesta4", comment: "")
        
        let pregunta8 = Pregunta()
        let preguntaDesc8 = PreguntaDescriptionLocalization()
        preguntaDesc8.pregunta = NSLocalizedString("pregunta8.pregunta", comment: "")
        pregunta8.RespuestaCorrecta = "4"
        pregunta8.IDRespuesta = "8"
        preguntaDesc8.IDRespuesta = "8"
        preguntaDesc8.Respuesta1 = NSLocalizedString("pregunta8.Respuesta1", comment: "")
        preguntaDesc8.Respuesta2 = NSLocalizedString("pregunta8.Respuesta2", comment: "")
        preguntaDesc8.Respuesta3 = NSLocalizedString("pregunta8.Respuesta3", comment: "")
        preguntaDesc8.Respuesta4 = NSLocalizedString("pregunta8.Respuesta4", comment: "")
        
        let pregunta9 = Pregunta()
        let preguntaDesc9 = PreguntaDescriptionLocalization()
        preguntaDesc9.pregunta = NSLocalizedString("pregunta9.pregunta", comment: "")
        pregunta9.RespuestaCorrecta = "4"
        pregunta9.IDRespuesta = "9"
        preguntaDesc9.IDRespuesta = "9"
        preguntaDesc9.Respuesta1 = NSLocalizedString("pregunta9.Respuesta1", comment: "")
        preguntaDesc9.Respuesta2 = NSLocalizedString("pregunta9.Respuesta2", comment: "")
        preguntaDesc9.Respuesta3 = NSLocalizedString("pregunta9.Respuesta3", comment: "")
        preguntaDesc9.Respuesta4 = NSLocalizedString("pregunta9.Respuesta4", comment: "")
        
        let pregunta10 = Pregunta()
        let preguntaDesc10 = PreguntaDescriptionLocalization()
        preguntaDesc1.pregunta = NSLocalizedString("pregunta10.pregunta", comment: "")
        pregunta10.RespuestaCorrecta = "4"
        pregunta10.IDRespuesta = "10"
        preguntaDesc10.IDRespuesta = "10"
        preguntaDesc10.Respuesta1 = NSLocalizedString("pregunta10.Respuesta1", comment: "")
        preguntaDesc10.Respuesta2 = NSLocalizedString("pregunta10.Respuesta2", comment: "")
        preguntaDesc10.Respuesta3 = NSLocalizedString("pregunta10.Respuesta3", comment: "")
        preguntaDesc10.Respuesta4 = NSLocalizedString("pregunta10.Respuesta4", comment: "")
        
        let pregunta11 = Pregunta()
        let preguntaDesc11 = PreguntaDescriptionLocalization()
        preguntaDesc11.pregunta = NSLocalizedString("pregunta11.pregunta", comment: "")
        pregunta11.RespuestaCorrecta = "4"
        pregunta11.IDRespuesta = "11"
        preguntaDesc11.IDRespuesta = "11"
        preguntaDesc11.Respuesta1 = NSLocalizedString("pregunta11.Respuesta1", comment: "")
        preguntaDesc11.Respuesta2 = NSLocalizedString("pregunta11.Respuesta2", comment: "")
        preguntaDesc11.Respuesta3 = NSLocalizedString("pregunta11.Respuesta3", comment: "")
        preguntaDesc11.Respuesta4 = NSLocalizedString("pregunta11.Respuesta4", comment: "")
        
        let pregunta12 = Pregunta()
        let preguntaDesc12 = PreguntaDescriptionLocalization()
        preguntaDesc12.pregunta = NSLocalizedString("pregunta12.pregunta", comment: "")
        pregunta12.RespuestaCorrecta = "4"
        pregunta12.IDRespuesta = "12"
        preguntaDesc12.IDRespuesta = "12"
        preguntaDesc12.Respuesta1 = NSLocalizedString("pregunta12.Respuesta1", comment: "")
        preguntaDesc12.Respuesta2 = NSLocalizedString("pregunta12.Respuesta2", comment: "")
        preguntaDesc12.Respuesta3 = NSLocalizedString("pregunta12.Respuesta3", comment: "")
        preguntaDesc12.Respuesta4 = NSLocalizedString("pregunta12.Respuesta4", comment: "")
        
        let pregunta13 = Pregunta()
        let preguntaDesc13 = PreguntaDescriptionLocalization()
        preguntaDesc13.pregunta = NSLocalizedString("pregunta13.pregunta", comment: "")
        pregunta13.RespuestaCorrecta = "4"
        pregunta13.IDRespuesta = "13"
        preguntaDesc13.IDRespuesta = "13"
        preguntaDesc13.Respuesta1 = NSLocalizedString("pregunta13.Respuesta1", comment: "")
        preguntaDesc13.Respuesta2 = NSLocalizedString("pregunta13.Respuesta2", comment: "")
        preguntaDesc13.Respuesta3 = NSLocalizedString("pregunta13.Respuesta3", comment: "")
        preguntaDesc13.Respuesta4 = NSLocalizedString("pregunta13.Respuesta4", comment: "")
        
        let pregunta14 = Pregunta()
        let preguntaDesc14 = PreguntaDescriptionLocalization()
        preguntaDesc14.pregunta = NSLocalizedString("pregunta14.pregunta", comment: "")
        pregunta14.RespuestaCorrecta = "4"
        pregunta14.IDRespuesta = "14"
        preguntaDesc14.IDRespuesta = "14"
        preguntaDesc14.Respuesta1 = NSLocalizedString("pregunta14.Respuesta1", comment: "")
        preguntaDesc14.Respuesta2 = NSLocalizedString("pregunta14.Respuesta2", comment: "")
        preguntaDesc14.Respuesta3 = NSLocalizedString("pregunta14.Respuesta3", comment: "")
        preguntaDesc14.Respuesta4 = NSLocalizedString("pregunta14.Respuesta4", comment: "")
        
        let pregunta15 = Pregunta()
        let preguntaDesc15 = PreguntaDescriptionLocalization()
        preguntaDesc15.pregunta = NSLocalizedString("pregunta15.pregunta", comment: "")
        pregunta15.RespuestaCorrecta = "4"
        pregunta15.IDRespuesta = "15"
        preguntaDesc15.IDRespuesta = "15"
        preguntaDesc15.Respuesta1 = NSLocalizedString("pregunta15.Respuesta1", comment: "")
        preguntaDesc15.Respuesta2 = NSLocalizedString("pregunta15.Respuesta2", comment: "")
        preguntaDesc15.Respuesta3 = NSLocalizedString("pregunta15.Respuesta3", comment: "")
        preguntaDesc15.Respuesta4 = NSLocalizedString("pregunta15.Respuesta4", comment: "")
        
        let pregunta16 = Pregunta()
        let preguntaDesc16 = PreguntaDescriptionLocalization()
        preguntaDesc16.pregunta = NSLocalizedString("pregunta16.pregunta", comment: "")
        pregunta16.RespuestaCorrecta = "4"
        pregunta16.IDRespuesta = "16"
        preguntaDesc16.IDRespuesta = "16"
        preguntaDesc16.Respuesta1 = NSLocalizedString("pregunta16.Respuesta1", comment: "")
        preguntaDesc16.Respuesta2 = NSLocalizedString("pregunta16.Respuesta2", comment: "")
        preguntaDesc16.Respuesta3 = NSLocalizedString("pregunta16.Respuesta3", comment: "")
        preguntaDesc16.Respuesta4 = NSLocalizedString("pregunta16.Respuesta4", comment: "")
        
        let pregunta17 = Pregunta()
        let preguntaDesc17 = PreguntaDescriptionLocalization()
        preguntaDesc17.pregunta = NSLocalizedString("pregunta17.pregunta", comment: "")
        pregunta17.RespuestaCorrecta = "4"
        pregunta17.IDRespuesta = "17"
        preguntaDesc17.IDRespuesta = "17"
        preguntaDesc17.Respuesta1 = NSLocalizedString("pregunta17.Respuesta1", comment: "")
        preguntaDesc17.Respuesta2 = NSLocalizedString("pregunta17.Respuesta2", comment: "")
        preguntaDesc17.Respuesta3 = NSLocalizedString("pregunta17.Respuesta3", comment: "")
        preguntaDesc17.Respuesta4 = NSLocalizedString("pregunta17.Respuesta4", comment: "")
        
        let pregunta18 = Pregunta()
        let preguntaDesc18 = PreguntaDescriptionLocalization()
        preguntaDesc18.pregunta = NSLocalizedString("pregunta18.pregunta", comment: "")
        pregunta18.RespuestaCorrecta = "4"
        pregunta18.IDRespuesta = "18"
        preguntaDesc18.IDRespuesta = "18"
        preguntaDesc18.Respuesta1 = NSLocalizedString("pregunta18.Respuesta1", comment: "")
        preguntaDesc18.Respuesta2 = NSLocalizedString("pregunta18.Respuesta2", comment: "")
        preguntaDesc18.Respuesta3 = NSLocalizedString("pregunta18.Respuesta3", comment: "")
        preguntaDesc18.Respuesta4 = NSLocalizedString("pregunta18.Respuesta4", comment: "")
        
        let pregunta19 = Pregunta()
        let preguntaDesc19 = PreguntaDescriptionLocalization()
        preguntaDesc19.pregunta = NSLocalizedString("pregunta19.pregunta", comment: "")
        pregunta19.RespuestaCorrecta = "4"
        pregunta19.IDRespuesta = "19"
        preguntaDesc19.IDRespuesta = "19"
        preguntaDesc19.Respuesta1 = NSLocalizedString("pregunta19.Respuesta1", comment: "")
        preguntaDesc19.Respuesta2 = NSLocalizedString("pregunta19.Respuesta2", comment: "")
        preguntaDesc19.Respuesta3 = NSLocalizedString("pregunta19.Respuesta3", comment: "")
        preguntaDesc19.Respuesta4 = NSLocalizedString("pregunta19.Respuesta4", comment: "")
        
        let pregunta20 = Pregunta()
        let preguntaDesc20 = PreguntaDescriptionLocalization()
        preguntaDesc20.pregunta = NSLocalizedString("pregunta20.pregunta", comment: "")
        pregunta20.RespuestaCorrecta = "4"
        pregunta20.IDRespuesta = "20"
        preguntaDesc20.IDRespuesta = "20"
        preguntaDesc20.Respuesta1 = NSLocalizedString("pregunta20.Respuesta1", comment: "")
        preguntaDesc20.Respuesta2 = NSLocalizedString("pregunta20.Respuesta2", comment: "")
        preguntaDesc20.Respuesta3 = NSLocalizedString("pregunta20.Respuesta3", comment: "")
        preguntaDesc20.Respuesta4 = NSLocalizedString("pregunta20.Respuesta4", comment: "")
        
        let pregunta21 = Pregunta()
        let preguntaDesc21 = PreguntaDescriptionLocalization()
        preguntaDesc21.pregunta = NSLocalizedString("pregunta21.pregunta", comment: "")
        pregunta21.RespuestaCorrecta = "4"
        pregunta21.IDRespuesta = "21"
        preguntaDesc21.IDRespuesta = "21"
        preguntaDesc21.Respuesta1 = NSLocalizedString("pregunta21.Respuesta1", comment: "")
        preguntaDesc21.Respuesta2 = NSLocalizedString("pregunta21.Respuesta2", comment: "")
        preguntaDesc21.Respuesta3 = NSLocalizedString("pregunta21.Respuesta3", comment: "")
        preguntaDesc21.Respuesta4 = NSLocalizedString("pregunta21.Respuesta4", comment: "")
        
        let pregunta22 = Pregunta()
        let preguntaDesc22 = PreguntaDescriptionLocalization()
        preguntaDesc22.pregunta = NSLocalizedString("pregunta22.pregunta", comment: "")
        pregunta22.RespuestaCorrecta = "4"
        pregunta22.IDRespuesta = "22"
        preguntaDesc22.IDRespuesta = "22"
        preguntaDesc22.Respuesta1 = NSLocalizedString("pregunta22.Respuesta1", comment: "")
        preguntaDesc22.Respuesta2 = NSLocalizedString("pregunta22.Respuesta2", comment: "")
        preguntaDesc22.Respuesta3 = NSLocalizedString("pregunta22.Respuesta3", comment: "")
        preguntaDesc22.Respuesta4 = NSLocalizedString("pregunta22.Respuesta4", comment: "")
        
        let pregunta23 = Pregunta()
        let preguntaDesc23 = PreguntaDescriptionLocalization()
        preguntaDesc23.pregunta = NSLocalizedString("pregunta23.pregunta", comment: "")
        pregunta23.RespuestaCorrecta = "4"
        pregunta23.IDRespuesta = "23"
        preguntaDesc23.IDRespuesta = "23"
        preguntaDesc23.Respuesta1 = NSLocalizedString("pregunta23.Respuesta1", comment: "")
        preguntaDesc23.Respuesta2 = NSLocalizedString("pregunta23.Respuesta2", comment: "")
        preguntaDesc23.Respuesta3 = NSLocalizedString("pregunta23.Respuesta3", comment: "")
        preguntaDesc23.Respuesta4 = NSLocalizedString("pregunta23.Respuesta4", comment: "")
        
        let pregunta24 = Pregunta()
        let preguntaDesc24 = PreguntaDescriptionLocalization()
        preguntaDesc24.pregunta = NSLocalizedString("pregunta24.pregunta", comment: "")
        pregunta24.RespuestaCorrecta = "4"
        pregunta24.IDRespuesta = "24"
        preguntaDesc24.IDRespuesta = "24"
        preguntaDesc24.Respuesta1 = NSLocalizedString("pregunta24.Respuesta1", comment: "")
        preguntaDesc24.Respuesta2 = NSLocalizedString("pregunta24.Respuesta2", comment: "")
        preguntaDesc24.Respuesta3 = NSLocalizedString("pregunta24.Respuesta3", comment: "")
        preguntaDesc24.Respuesta4 = NSLocalizedString("pregunta24.Respuesta4", comment: "")
        
        let pregunta25 = Pregunta()
        let preguntaDesc25 = PreguntaDescriptionLocalization()
        preguntaDesc25.pregunta = NSLocalizedString("pregunta25.pregunta", comment: "")
        pregunta25.RespuestaCorrecta = "4"
        pregunta25.IDRespuesta = "25"
        preguntaDesc25.IDRespuesta = "25"
        preguntaDesc25.Respuesta1 = NSLocalizedString("pregunta25.Respuesta1", comment: "")
        preguntaDesc25.Respuesta2 = NSLocalizedString("pregunta25.Respuesta2", comment: "")
        preguntaDesc25.Respuesta3 = NSLocalizedString("pregunta25.Respuesta3", comment: "")
        preguntaDesc25.Respuesta4 = NSLocalizedString("pregunta25.Respuesta4", comment: "")
        
        let pregunta26 = Pregunta()
        let preguntaDesc26 = PreguntaDescriptionLocalization()
        preguntaDesc26.pregunta = NSLocalizedString("pregunta26.pregunta", comment: "")
        pregunta26.RespuestaCorrecta = "4"
        pregunta26.IDRespuesta = "26"
        preguntaDesc26.IDRespuesta = "26"
        preguntaDesc26.Respuesta1 = NSLocalizedString("pregunta26.Respuesta1", comment: "")
        preguntaDesc26.Respuesta2 = NSLocalizedString("pregunta26.Respuesta2", comment: "")
        preguntaDesc26.Respuesta3 = NSLocalizedString("pregunta26.Respuesta3", comment: "")
        preguntaDesc26.Respuesta4 = NSLocalizedString("pregunta26.Respuesta4", comment: "")
        
        let pregunta27 = Pregunta()
        let preguntaDesc27 = PreguntaDescriptionLocalization()
        preguntaDesc27.pregunta = NSLocalizedString("pregunta27.pregunta", comment: "")
        pregunta27.RespuestaCorrecta = "4"
        pregunta27.IDRespuesta = "27"
        preguntaDesc27.IDRespuesta = "27"
        preguntaDesc27.Respuesta1 = NSLocalizedString("pregunta27.Respuesta1", comment: "")
        preguntaDesc27.Respuesta2 = NSLocalizedString("pregunta27.Respuesta2", comment: "")
        preguntaDesc27.Respuesta3 = NSLocalizedString("pregunta27.Respuesta3", comment: "")
        preguntaDesc27.Respuesta4 = NSLocalizedString("pregunta27.Respuesta4", comment: "")
        
        let pregunta28 = Pregunta()
        let preguntaDesc28 = PreguntaDescriptionLocalization()
        preguntaDesc28.pregunta = NSLocalizedString("pregunta28.pregunta", comment: "")
        pregunta28.RespuestaCorrecta = "4"
        pregunta28.IDRespuesta = "28"
        preguntaDesc28.IDRespuesta = "28"
        preguntaDesc28.Respuesta1 = NSLocalizedString("pregunta28.Respuesta1", comment: "")
        preguntaDesc28.Respuesta2 = NSLocalizedString("pregunta28.Respuesta2", comment: "")
        preguntaDesc28.Respuesta3 = NSLocalizedString("pregunta28.Respuesta3", comment: "")
        preguntaDesc28.Respuesta4 = NSLocalizedString("pregunta28.Respuesta4", comment: "")
        
        let pregunta29 = Pregunta()
        let preguntaDesc29 = PreguntaDescriptionLocalization()
        preguntaDesc29.pregunta = NSLocalizedString("pregunta29.pregunta", comment: "")
        pregunta29.RespuestaCorrecta = "4"
        pregunta29.IDRespuesta = "29"
        preguntaDesc29.IDRespuesta = "29"
        preguntaDesc29.Respuesta1 = NSLocalizedString("pregunta29.Respuesta1", comment: "")
        preguntaDesc29.Respuesta2 = NSLocalizedString("pregunta29.Respuesta2", comment: "")
        preguntaDesc29.Respuesta3 = NSLocalizedString("pregunta29.Respuesta3", comment: "")
        preguntaDesc29.Respuesta4 = NSLocalizedString("pregunta29.Respuesta4", comment: "")
        
        let pregunta30 = Pregunta()
        let preguntaDesc30 = PreguntaDescriptionLocalization()
        preguntaDesc30.pregunta = NSLocalizedString("pregunta30.pregunta", comment: "")
        pregunta30.RespuestaCorrecta = "4"
        pregunta30.IDRespuesta = "30"
        preguntaDesc30.IDRespuesta = "30"
        preguntaDesc30.Respuesta1 = NSLocalizedString("pregunta30.Respuesta1", comment: "")
        preguntaDesc30.Respuesta2 = NSLocalizedString("pregunta30.Respuesta2", comment: "")
        preguntaDesc30.Respuesta3 = NSLocalizedString("pregunta30.Respuesta3", comment: "")
        preguntaDesc30.Respuesta4 = NSLocalizedString("pregunta30.Respuesta4", comment: "")
        
        let pregunta31 = Pregunta()
        let preguntaDesc31 = PreguntaDescriptionLocalization()
        preguntaDesc31.pregunta = NSLocalizedString("pregunta31.pregunta", comment: "")
        pregunta31.RespuestaCorrecta = "4"
        pregunta31.IDRespuesta = "31"
        preguntaDesc31.IDRespuesta = "31"
        preguntaDesc31.Respuesta1 = NSLocalizedString("pregunta31.Respuesta1", comment: "")
        preguntaDesc31.Respuesta2 = NSLocalizedString("pregunta31.Respuesta2", comment: "")
        preguntaDesc31.Respuesta3 = NSLocalizedString("pregunta31.Respuesta3", comment: "")
        preguntaDesc31.Respuesta4 = NSLocalizedString("pregunta31.Respuesta4", comment: "")
        
        let pregunta32 = Pregunta()
        let preguntaDesc32 = PreguntaDescriptionLocalization()
        preguntaDesc32.pregunta = NSLocalizedString("pregunta32.pregunta", comment: "")
        pregunta32.RespuestaCorrecta = "4"
        pregunta32.IDRespuesta = "32"
        preguntaDesc32.IDRespuesta = "32"
        preguntaDesc32.Respuesta1 = NSLocalizedString("pregunta32.Respuesta1", comment: "")
        preguntaDesc32.Respuesta2 = NSLocalizedString("pregunta32.Respuesta2", comment: "")
        preguntaDesc32.Respuesta3 = NSLocalizedString("pregunta32.Respuesta3", comment: "")
        preguntaDesc32.Respuesta4 = NSLocalizedString("pregunta32.Respuesta4", comment: "")
        
        let pregunta33 = Pregunta()
        let preguntaDesc33 = PreguntaDescriptionLocalization()
        preguntaDesc33.pregunta = NSLocalizedString("pregunta33.pregunta", comment: "")
        pregunta33.RespuestaCorrecta = "4"
        pregunta33.IDRespuesta = "33"
        preguntaDesc33.IDRespuesta = "33"
        preguntaDesc33.Respuesta1 = NSLocalizedString("pregunta33.Respuesta1", comment: "")
        preguntaDesc33.Respuesta2 = NSLocalizedString("pregunta33.Respuesta2", comment: "")
        preguntaDesc33.Respuesta3 = NSLocalizedString("pregunta33.Respuesta3", comment: "")
        preguntaDesc33.Respuesta4 = NSLocalizedString("pregunta33.Respuesta4", comment: "")
        
        let pregunta34 = Pregunta()
        let preguntaDesc34 = PreguntaDescriptionLocalization()
        preguntaDesc34.pregunta = NSLocalizedString("pregunta34.pregunta", comment: "")
        pregunta34.RespuestaCorrecta = "4"
        pregunta34.IDRespuesta = "34"
        preguntaDesc34.IDRespuesta = "34"
        preguntaDesc34.Respuesta1 = NSLocalizedString("pregunta34.Respuesta1", comment: "")
        preguntaDesc34.Respuesta2 = NSLocalizedString("pregunta34.Respuesta2", comment: "")
        preguntaDesc34.Respuesta3 = NSLocalizedString("pregunta34.Respuesta3", comment: "")
        preguntaDesc34.Respuesta4 = NSLocalizedString("pregunta34.Respuesta4", comment: "")
        
        let pregunta35 = Pregunta()
        let preguntaDesc35 = PreguntaDescriptionLocalization()
        preguntaDesc35.pregunta = NSLocalizedString("pregunta35.pregunta", comment: "")
        pregunta35.RespuestaCorrecta = "4"
        pregunta35.IDRespuesta = "35"
        preguntaDesc35.IDRespuesta = "35"
        preguntaDesc35.Respuesta1 = NSLocalizedString("pregunta35.Respuesta1", comment: "")
        preguntaDesc35.Respuesta2 = NSLocalizedString("pregunta35.Respuesta2", comment: "")
        preguntaDesc35.Respuesta3 = NSLocalizedString("pregunta35.Respuesta3", comment: "")
        preguntaDesc35.Respuesta4 = NSLocalizedString("pregunta35.Respuesta4", comment: "")
        
        let pregunta36 = Pregunta()
        let preguntaDesc36 = PreguntaDescriptionLocalization()
        preguntaDesc36.pregunta = NSLocalizedString("pregunta36.pregunta", comment: "")
        pregunta36.RespuestaCorrecta = "4"
        pregunta36.IDRespuesta = "36"
        preguntaDesc36.IDRespuesta = "36"
        preguntaDesc36.Respuesta1 = NSLocalizedString("pregunta36.Respuesta1", comment: "")
        preguntaDesc36.Respuesta2 = NSLocalizedString("pregunta36.Respuesta2", comment: "")
        preguntaDesc36.Respuesta3 = NSLocalizedString("pregunta36.Respuesta3", comment: "")
        preguntaDesc36.Respuesta4 = NSLocalizedString("pregunta36.Respuesta4", comment: "")
        
        let pregunta37 = Pregunta()
        let preguntaDesc37 = PreguntaDescriptionLocalization()
        preguntaDesc37.pregunta = NSLocalizedString("pregunta37.pregunta", comment: "")
        pregunta37.RespuestaCorrecta = "4"
        pregunta37.IDRespuesta = "37"
        preguntaDesc37.IDRespuesta = "37"
        preguntaDesc37.Respuesta1 = NSLocalizedString("pregunta37.Respuesta1", comment: "")
        preguntaDesc37.Respuesta2 = NSLocalizedString("pregunta37.Respuesta2", comment: "")
        preguntaDesc37.Respuesta3 = NSLocalizedString("pregunta37.Respuesta3", comment: "")
        preguntaDesc37.Respuesta4 = NSLocalizedString("pregunta37.Respuesta4", comment: "")
        
        let pregunta38 = Pregunta()
        let preguntaDesc38 = PreguntaDescriptionLocalization()
        preguntaDesc38.pregunta = NSLocalizedString("pregunta38.pregunta", comment: "")
        pregunta38.RespuestaCorrecta = "4"
        pregunta38.IDRespuesta = "38"
        preguntaDesc38.IDRespuesta = "38"
        preguntaDesc38.Respuesta1 = NSLocalizedString("pregunta38.Respuesta1", comment: "")
        preguntaDesc38.Respuesta2 = NSLocalizedString("pregunta38.Respuesta2", comment: "")
        preguntaDesc38.Respuesta3 = NSLocalizedString("pregunta38.Respuesta3", comment: "")
        preguntaDesc38.Respuesta4 = NSLocalizedString("pregunta38.Respuesta4", comment: "")
        
        let pregunta39 = Pregunta()
        let preguntaDesc39 = PreguntaDescriptionLocalization()
        preguntaDesc39.pregunta = NSLocalizedString("pregunta39.pregunta", comment: "")
        pregunta39.RespuestaCorrecta = "4"
        pregunta39.IDRespuesta = "39"
        preguntaDesc39.IDRespuesta = "39"
        preguntaDesc39.Respuesta1 = NSLocalizedString("pregunta39.Respuesta1", comment: "")
        preguntaDesc39.Respuesta2 = NSLocalizedString("pregunta39.Respuesta2", comment: "")
        preguntaDesc39.Respuesta3 = NSLocalizedString("pregunta39.Respuesta3", comment: "")
        preguntaDesc39.Respuesta4 = NSLocalizedString("pregunta39.Respuesta4", comment: "")
        
        let pregunta40 = Pregunta()
        let preguntaDesc40 = PreguntaDescriptionLocalization()
        preguntaDesc40.pregunta = NSLocalizedString("pregunta40.pregunta", comment: "")
        pregunta40.RespuestaCorrecta = "4"
        pregunta40.IDRespuesta = "40"
        preguntaDesc40.IDRespuesta = "40"
        preguntaDesc40.Respuesta1 = NSLocalizedString("pregunta40.Respuesta1", comment: "")
        preguntaDesc40.Respuesta2 = NSLocalizedString("pregunta40.Respuesta2", comment: "")
        preguntaDesc40.Respuesta3 = NSLocalizedString("pregunta40.Respuesta3", comment: "")
        preguntaDesc40.Respuesta4 = NSLocalizedString("pregunta40.Respuesta4", comment: "")
        
        let pregunta41 = Pregunta()
        let preguntaDesc41 = PreguntaDescriptionLocalization()
        preguntaDesc41.pregunta = NSLocalizedString("pregunta41.pregunta", comment: "")
        pregunta41.RespuestaCorrecta = "4"
        pregunta41.IDRespuesta = "41"
        preguntaDesc41.IDRespuesta = "41"
        preguntaDesc41.Respuesta1 = NSLocalizedString("pregunta41.Respuesta1", comment: "")
        preguntaDesc41.Respuesta2 = NSLocalizedString("pregunta41.Respuesta2", comment: "")
        preguntaDesc41.Respuesta3 = NSLocalizedString("pregunta41.Respuesta3", comment: "")
        preguntaDesc41.Respuesta4 = NSLocalizedString("pregunta41.Respuesta4", comment: "")
        
        let pregunta42 = Pregunta()
        let preguntaDesc42 = PreguntaDescriptionLocalization()
        preguntaDesc42.pregunta = NSLocalizedString("pregunta42.pregunta", comment: "")
        pregunta42.RespuestaCorrecta = "4"
        pregunta42.IDRespuesta = "42"
        preguntaDesc42.IDRespuesta = "42"
        preguntaDesc42.Respuesta1 = NSLocalizedString("pregunta42.Respuesta1", comment: "")
        preguntaDesc42.Respuesta2 = NSLocalizedString("pregunta42.Respuesta2", comment: "")
        preguntaDesc42.Respuesta3 = NSLocalizedString("pregunta42.Respuesta3", comment: "")
        preguntaDesc42.Respuesta4 = NSLocalizedString("pregunta42.Respuesta4", comment: "")
        
        let pregunta43 = Pregunta()
        let preguntaDesc43 = PreguntaDescriptionLocalization()
        preguntaDesc43.pregunta = NSLocalizedString("pregunta43.pregunta", comment: "")
        pregunta43.RespuestaCorrecta = "4"
        pregunta43.IDRespuesta = "43"
        preguntaDesc43.IDRespuesta = "43"
        preguntaDesc43.Respuesta1 = NSLocalizedString("pregunta43.Respuesta1", comment: "")
        preguntaDesc43.Respuesta2 = NSLocalizedString("pregunta43.Respuesta2", comment: "")
        preguntaDesc43.Respuesta3 = NSLocalizedString("pregunta43.Respuesta3", comment: "")
        preguntaDesc43.Respuesta4 = NSLocalizedString("pregunta43.Respuesta4", comment: "")
        
        let pregunta44 = Pregunta()
        let preguntaDesc44 = PreguntaDescriptionLocalization()
        preguntaDesc44.pregunta = NSLocalizedString("pregunta44.pregunta", comment: "")
        pregunta44.RespuestaCorrecta = "4"
        pregunta44.IDRespuesta = "44"
        preguntaDesc44.IDRespuesta = "44"
        preguntaDesc44.Respuesta1 = NSLocalizedString("pregunta44.Respuesta1", comment: "")
        preguntaDesc44.Respuesta2 = NSLocalizedString("pregunta44.Respuesta2", comment: "")
        preguntaDesc44.Respuesta3 = NSLocalizedString("pregunta44.Respuesta3", comment: "")
        preguntaDesc44.Respuesta4 = NSLocalizedString("pregunta44.Respuesta4", comment: "")
        
        let pregunta45 = Pregunta()
        let preguntaDesc45 = PreguntaDescriptionLocalization()
        preguntaDesc45.pregunta = NSLocalizedString("pregunta45.pregunta", comment: "")
        pregunta45.RespuestaCorrecta = "4"
        pregunta45.IDRespuesta = "45"
        preguntaDesc45.IDRespuesta = "45"
        preguntaDesc45.Respuesta1 = NSLocalizedString("pregunta45.Respuesta1", comment: "")
        preguntaDesc45.Respuesta2 = NSLocalizedString("pregunta45.Respuesta2", comment: "")
        preguntaDesc45.Respuesta3 = NSLocalizedString("pregunta45.Respuesta3", comment: "")
        preguntaDesc45.Respuesta4 = NSLocalizedString("pregunta45.Respuesta4", comment: "")
        
        let pregunta46 = Pregunta()
        let preguntaDesc46 = PreguntaDescriptionLocalization()
        preguntaDesc46.pregunta = NSLocalizedString("pregunta46.pregunta", comment: "")
        pregunta46.RespuestaCorrecta = "4"
        pregunta46.IDRespuesta = "46"
        preguntaDesc46.IDRespuesta = "46"
        preguntaDesc46.Respuesta1 = NSLocalizedString("pregunta46.Respuesta1", comment: "")
        preguntaDesc46.Respuesta2 = NSLocalizedString("pregunta46.Respuesta2", comment: "")
        preguntaDesc46.Respuesta3 = NSLocalizedString("pregunta46.Respuesta3", comment: "")
        preguntaDesc46.Respuesta4 = NSLocalizedString("pregunta46.Respuesta4", comment: "")
        
        let pregunta47 = Pregunta()
        let preguntaDesc47 = PreguntaDescriptionLocalization()
        preguntaDesc47.pregunta = NSLocalizedString("pregunta47.pregunta", comment: "")
        pregunta47.RespuestaCorrecta = "4"
        pregunta47.IDRespuesta = "47"
        preguntaDesc47.IDRespuesta = "47"
        preguntaDesc47.Respuesta1 = NSLocalizedString("pregunta47.Respuesta1", comment: "")
        preguntaDesc47.Respuesta2 = NSLocalizedString("pregunta47.Respuesta2", comment: "")
        preguntaDesc47.Respuesta3 = NSLocalizedString("pregunta47.Respuesta3", comment: "")
        preguntaDesc47.Respuesta4 = NSLocalizedString("pregunta47.Respuesta4", comment: "")
        
        let pregunta48 = Pregunta()
        let preguntaDesc48 = PreguntaDescriptionLocalization()
        preguntaDesc48.pregunta = NSLocalizedString("pregunta48.pregunta", comment: "")
        pregunta48.RespuestaCorrecta = "4"
        pregunta48.IDRespuesta = "48"
        preguntaDesc48.IDRespuesta = "48"
        preguntaDesc48.Respuesta1 = NSLocalizedString("pregunta48.Respuesta1", comment: "")
        preguntaDesc48.Respuesta2 = NSLocalizedString("pregunta48.Respuesta2", comment: "")
        preguntaDesc48.Respuesta3 = NSLocalizedString("pregunta48.Respuesta3", comment: "")
        preguntaDesc48.Respuesta4 = NSLocalizedString("pregunta48.Respuesta4", comment: "")
        
        let pregunta49 = Pregunta()
        let preguntaDesc49 = PreguntaDescriptionLocalization()
        preguntaDesc49.pregunta = NSLocalizedString("pregunta49.pregunta", comment: "")
        pregunta49.RespuestaCorrecta = "4"
        pregunta49.IDRespuesta = "49"
        preguntaDesc49.IDRespuesta = "49"
        preguntaDesc49.Respuesta1 = NSLocalizedString("pregunta49.Respuesta1", comment: "")
        preguntaDesc49.Respuesta2 = NSLocalizedString("pregunta49.Respuesta2", comment: "")
        preguntaDesc49.Respuesta3 = NSLocalizedString("pregunta49.Respuesta3", comment: "")
        preguntaDesc49.Respuesta4 = NSLocalizedString("pregunta49.Respuesta4", comment: "")
        
        let pregunta50 = Pregunta()
        let preguntaDesc50 = PreguntaDescriptionLocalization()
        preguntaDesc50.pregunta = NSLocalizedString("pregunta50.pregunta", comment: "")
        pregunta50.RespuestaCorrecta = "4"
        pregunta50.IDRespuesta = "50"
        preguntaDesc50.IDRespuesta = "50"
        preguntaDesc50.Respuesta1 = NSLocalizedString("pregunta50.Respuesta1", comment: "")
        preguntaDesc50.Respuesta2 = NSLocalizedString("pregunta50.Respuesta2", comment: "")
        preguntaDesc50.Respuesta3 = NSLocalizedString("pregunta50.Respuesta3", comment: "")
        preguntaDesc50.Respuesta4 = NSLocalizedString("pregunta50.Respuesta4", comment: "")
        
        let pregunta51 = Pregunta()
        let preguntaDesc51 = PreguntaDescriptionLocalization()
        preguntaDesc51.pregunta = NSLocalizedString("pregunta51.pregunta", comment: "")
        pregunta51.RespuestaCorrecta = "4"
        pregunta51.IDRespuesta = "51"
        preguntaDesc51.IDRespuesta = "51"
        preguntaDesc51.Respuesta1 = NSLocalizedString("pregunta51.Respuesta1", comment: "")
        preguntaDesc51.Respuesta2 = NSLocalizedString("pregunta51.Respuesta2", comment: "")
        preguntaDesc51.Respuesta3 = NSLocalizedString("pregunta51.Respuesta3", comment: "")
        preguntaDesc51.Respuesta4 = NSLocalizedString("pregunta51.Respuesta4", comment: "")
        
        let pregunta52 = Pregunta()
        let preguntaDesc52 = PreguntaDescriptionLocalization()
        preguntaDesc52.pregunta = NSLocalizedString("pregunta52.pregunta", comment: "")
        pregunta52.RespuestaCorrecta = "4"
        pregunta52.IDRespuesta = "52"
        preguntaDesc52.IDRespuesta = "52"
        preguntaDesc52.Respuesta1 = NSLocalizedString("pregunta52.Respuesta1", comment: "")
        preguntaDesc52.Respuesta2 = NSLocalizedString("pregunta52.Respuesta2", comment: "")
        preguntaDesc52.Respuesta3 = NSLocalizedString("pregunta52.Respuesta3", comment: "")
        preguntaDesc52.Respuesta4 = NSLocalizedString("pregunta52.Respuesta4", comment: "")
        
        let pregunta53 = Pregunta()
        let preguntaDesc53 = PreguntaDescriptionLocalization()
        preguntaDesc53.pregunta = NSLocalizedString("pregunta53.pregunta", comment: "")
        pregunta53.RespuestaCorrecta = "4"
        pregunta53.IDRespuesta = "53"
        preguntaDesc53.IDRespuesta = "53"
        preguntaDesc53.Respuesta1 = NSLocalizedString("pregunta53.Respuesta1", comment: "")
        preguntaDesc53.Respuesta2 = NSLocalizedString("pregunta53.Respuesta2", comment: "")
        preguntaDesc53.Respuesta3 = NSLocalizedString("pregunta53.Respuesta3", comment: "")
        preguntaDesc53.Respuesta4 = NSLocalizedString("pregunta53.Respuesta4", comment: "")
        
        let pregunta54 = Pregunta()
        let preguntaDesc54 = PreguntaDescriptionLocalization()
        preguntaDesc54.pregunta = NSLocalizedString("pregunta54.pregunta", comment: "")
        pregunta54.RespuestaCorrecta = "4"
        pregunta54.IDRespuesta = "54"
        preguntaDesc54.IDRespuesta = "54"
        preguntaDesc54.Respuesta1 = NSLocalizedString("pregunta54.Respuesta1", comment: "")
        preguntaDesc54.Respuesta2 = NSLocalizedString("pregunta54.Respuesta2", comment: "")
        preguntaDesc54.Respuesta3 = NSLocalizedString("pregunta54.Respuesta3", comment: "")
        preguntaDesc54.Respuesta4 = NSLocalizedString("pregunta54.Respuesta4", comment: "")
        
        let pregunta55 = Pregunta()
        let preguntaDesc55 = PreguntaDescriptionLocalization()
        preguntaDesc55.pregunta = NSLocalizedString("pregunta55.pregunta", comment: "")
        pregunta55.RespuestaCorrecta = "4"
        pregunta55.IDRespuesta = "55"
        preguntaDesc55.IDRespuesta = "55"
        preguntaDesc55.Respuesta1 = NSLocalizedString("pregunta55.Respuesta1", comment: "")
        preguntaDesc55.Respuesta2 = NSLocalizedString("pregunta55.Respuesta2", comment: "")
        preguntaDesc55.Respuesta3 = NSLocalizedString("pregunta55.Respuesta3", comment: "")
        preguntaDesc55.Respuesta4 = NSLocalizedString("pregunta55.Respuesta4", comment: "")
        
        let pregunta56 = Pregunta()
        let preguntaDesc56 = PreguntaDescriptionLocalization()
        preguntaDesc56.pregunta = NSLocalizedString("pregunta56.pregunta", comment: "")
        pregunta56.RespuestaCorrecta = "4"
        pregunta56.IDRespuesta = "56"
        preguntaDesc56.IDRespuesta = "56"
        preguntaDesc56.Respuesta1 = NSLocalizedString("pregunta56.Respuesta1", comment: "")
        preguntaDesc56.Respuesta2 = NSLocalizedString("pregunta56.Respuesta2", comment: "")
        preguntaDesc56.Respuesta3 = NSLocalizedString("pregunta56.Respuesta3", comment: "")
        preguntaDesc56.Respuesta4 = NSLocalizedString("pregunta56.Respuesta4", comment: "")
        
        let pregunta57 = Pregunta()
        let preguntaDesc57 = PreguntaDescriptionLocalization()
        preguntaDesc57.pregunta = NSLocalizedString("pregunta57.pregunta", comment: "")
        pregunta57.RespuestaCorrecta = "4"
        pregunta57.IDRespuesta = "57"
        preguntaDesc57.IDRespuesta = "57"
        preguntaDesc57.Respuesta1 = NSLocalizedString("pregunta57.Respuesta1", comment: "")
        preguntaDesc57.Respuesta2 = NSLocalizedString("pregunta57.Respuesta2", comment: "")
        preguntaDesc57.Respuesta3 = NSLocalizedString("pregunta57.Respuesta3", comment: "")
        preguntaDesc57.Respuesta4 = NSLocalizedString("pregunta57.Respuesta4", comment: "")
        
        let pregunta58 = Pregunta()
        let preguntaDesc58 = PreguntaDescriptionLocalization()
        preguntaDesc58.pregunta = NSLocalizedString("pregunta58.pregunta", comment: "")
        pregunta58.RespuestaCorrecta = "4"
        pregunta58.IDRespuesta = "58"
        preguntaDesc58.IDRespuesta = "58"
        preguntaDesc58.Respuesta1 = NSLocalizedString("pregunta58.Respuesta1", comment: "")
        preguntaDesc58.Respuesta2 = NSLocalizedString("pregunta58.Respuesta2", comment: "")
        preguntaDesc58.Respuesta3 = NSLocalizedString("pregunta58.Respuesta3", comment: "")
        preguntaDesc58.Respuesta4 = NSLocalizedString("pregunta58.Respuesta4", comment: "")
        
        let pregunta59 = Pregunta()
        let preguntaDesc59 = PreguntaDescriptionLocalization()
        preguntaDesc59.pregunta = NSLocalizedString("pregunta59.pregunta", comment: "")
        pregunta59.RespuestaCorrecta = "4"
        pregunta59.IDRespuesta = "59"
        preguntaDesc59.IDRespuesta = "59"
        preguntaDesc59.Respuesta1 = NSLocalizedString("pregunta59.Respuesta1", comment: "")
        preguntaDesc59.Respuesta2 = NSLocalizedString("pregunta59.Respuesta2", comment: "")
        preguntaDesc59.Respuesta3 = NSLocalizedString("pregunta59.Respuesta3", comment: "")
        preguntaDesc59.Respuesta4 = NSLocalizedString("pregunta59.Respuesta4", comment: "")
        
        let pregunta60 = Pregunta()
        let preguntaDesc60 = PreguntaDescriptionLocalization()
        preguntaDesc60.pregunta = NSLocalizedString("pregunta60.pregunta", comment: "")
        pregunta60.RespuestaCorrecta = "4"
        pregunta60.IDRespuesta = "60"
        preguntaDesc60.IDRespuesta = "60"
        preguntaDesc60.Respuesta1 = NSLocalizedString("pregunta60.Respuesta1", comment: "")
        preguntaDesc60.Respuesta2 = NSLocalizedString("pregunta60.Respuesta2", comment: "")
        preguntaDesc60.Respuesta3 = NSLocalizedString("pregunta60.Respuesta3", comment: "")
        preguntaDesc60.Respuesta4 = NSLocalizedString("pregunta60.Respuesta4", comment: "")
        
        let pregunta61 = Pregunta()
        let preguntaDesc61 = PreguntaDescriptionLocalization()
        preguntaDesc61.pregunta = NSLocalizedString("pregunta61.pregunta", comment: "")
        pregunta61.RespuestaCorrecta = "4"
        pregunta61.IDRespuesta = "61"
        preguntaDesc61.IDRespuesta = "61"
        preguntaDesc61.Respuesta1 = NSLocalizedString("pregunta61.Respuesta1", comment: "")
        preguntaDesc61.Respuesta2 = NSLocalizedString("pregunta61.Respuesta2", comment: "")
        preguntaDesc61.Respuesta3 = NSLocalizedString("pregunta61.Respuesta3", comment: "")
        preguntaDesc61.Respuesta4 = NSLocalizedString("pregunta61.Respuesta4", comment: "")
        
        let pregunta62 = Pregunta()
        let preguntaDesc62 = PreguntaDescriptionLocalization()
        preguntaDesc62.pregunta = NSLocalizedString("pregunta62.pregunta", comment: "")
        pregunta62.RespuestaCorrecta = "4"
        pregunta62.IDRespuesta = "62"
        preguntaDesc62.IDRespuesta = "62"
        preguntaDesc62.Respuesta1 = NSLocalizedString("pregunta62.Respuesta1", comment: "")
        preguntaDesc62.Respuesta2 = NSLocalizedString("pregunta62.Respuesta2", comment: "")
        preguntaDesc62.Respuesta3 = NSLocalizedString("pregunta62.Respuesta3", comment: "")
        preguntaDesc62.Respuesta4 = NSLocalizedString("pregunta62.Respuesta4", comment: "")
        
        let pregunta63 = Pregunta()
        let preguntaDesc63 = PreguntaDescriptionLocalization()
        preguntaDesc63.pregunta = NSLocalizedString("pregunta63.pregunta", comment: "")
        pregunta63.RespuestaCorrecta = "4"
        pregunta63.IDRespuesta = "63"
        preguntaDesc63.IDRespuesta = "63"
        preguntaDesc63.Respuesta1 = NSLocalizedString("pregunta63.Respuesta1", comment: "")
        preguntaDesc63.Respuesta2 = NSLocalizedString("pregunta63.Respuesta2", comment: "")
        preguntaDesc63.Respuesta3 = NSLocalizedString("pregunta63.Respuesta3", comment: "")
        preguntaDesc63.Respuesta4 = NSLocalizedString("pregunta63.Respuesta4", comment: "")
        
        let pregunta64 = Pregunta()
        let preguntaDesc64 = PreguntaDescriptionLocalization()
        preguntaDesc64.pregunta = NSLocalizedString("pregunta64.pregunta", comment: "")
        pregunta64.RespuestaCorrecta = "4"
        pregunta64.IDRespuesta = "64"
        preguntaDesc64.IDRespuesta = "64"
        preguntaDesc64.Respuesta1 = NSLocalizedString("pregunta64.Respuesta1", comment: "")
        preguntaDesc64.Respuesta2 = NSLocalizedString("pregunta64.Respuesta2", comment: "")
        preguntaDesc64.Respuesta3 = NSLocalizedString("pregunta64.Respuesta3", comment: "")
        preguntaDesc64.Respuesta4 = NSLocalizedString("pregunta64.Respuesta4", comment: "")
        
        let pregunta65 = Pregunta()
        let preguntaDesc65 = PreguntaDescriptionLocalization()
        preguntaDesc65.pregunta = NSLocalizedString("pregunta65.pregunta", comment: "")
        pregunta65.RespuestaCorrecta = "4"
        pregunta65.IDRespuesta = "65"
        preguntaDesc65.IDRespuesta = "65"
        preguntaDesc65.Respuesta1 = NSLocalizedString("pregunta65.Respuesta1", comment: "")
        preguntaDesc65.Respuesta2 = NSLocalizedString("pregunta65.Respuesta2", comment: "")
        preguntaDesc65.Respuesta3 = NSLocalizedString("pregunta65.Respuesta3", comment: "")
        preguntaDesc65.Respuesta4 = NSLocalizedString("pregunta65.Respuesta4", comment: "")
        
        let pregunta66 = Pregunta()
        let preguntaDesc66 = PreguntaDescriptionLocalization()
        preguntaDesc66.pregunta = NSLocalizedString("pregunta66.pregunta", comment: "")
        pregunta66.RespuestaCorrecta = "4"
        pregunta66.IDRespuesta = "66"
        preguntaDesc66.IDRespuesta = "66"
        preguntaDesc66.Respuesta1 = NSLocalizedString("pregunta66.Respuesta1", comment: "")
        preguntaDesc66.Respuesta2 = NSLocalizedString("pregunta66.Respuesta2", comment: "")
        preguntaDesc66.Respuesta3 = NSLocalizedString("pregunta66.Respuesta3", comment: "")
        preguntaDesc66.Respuesta4 = NSLocalizedString("pregunta66.Respuesta4", comment: "")
        
        let pregunta67 = Pregunta()
        let preguntaDesc67 = PreguntaDescriptionLocalization()
        preguntaDesc67.pregunta = NSLocalizedString("pregunta67.pregunta", comment: "")
        pregunta67.RespuestaCorrecta = "4"
        pregunta67.IDRespuesta = "67"
        preguntaDesc67.IDRespuesta = "67"
        preguntaDesc67.Respuesta1 = NSLocalizedString("pregunta67.Respuesta1", comment: "")
        preguntaDesc67.Respuesta2 = NSLocalizedString("pregunta67.Respuesta2", comment: "")
        preguntaDesc67.Respuesta3 = NSLocalizedString("pregunta67.Respuesta3", comment: "")
        preguntaDesc67.Respuesta4 = NSLocalizedString("pregunta67.Respuesta4", comment: "")
        
        let pregunta68 = Pregunta()
        let preguntaDesc68 = PreguntaDescriptionLocalization()
        preguntaDesc68.pregunta = NSLocalizedString("pregunta68.pregunta", comment: "")
        pregunta68.RespuestaCorrecta = "4"
        pregunta68.IDRespuesta = "68"
        preguntaDesc68.IDRespuesta = "68"
        preguntaDesc68.Respuesta1 = NSLocalizedString("pregunta68.Respuesta1", comment: "")
        preguntaDesc68.Respuesta2 = NSLocalizedString("pregunta68.Respuesta2", comment: "")
        preguntaDesc68.Respuesta3 = NSLocalizedString("pregunta68.Respuesta3", comment: "")
        preguntaDesc68.Respuesta4 = NSLocalizedString("pregunta68.Respuesta4", comment: "")
        
        let pregunta69 = Pregunta()
        let preguntaDesc69 = PreguntaDescriptionLocalization()
        preguntaDesc69.pregunta = NSLocalizedString("pregunta69.pregunta", comment: "")
        pregunta69.RespuestaCorrecta = "4"
        pregunta69.IDRespuesta = "69"
        preguntaDesc69.IDRespuesta = "69"
        preguntaDesc69.Respuesta1 = NSLocalizedString("pregunta69.Respuesta1", comment: "")
        preguntaDesc69.Respuesta2 = NSLocalizedString("pregunta69.Respuesta2", comment: "")
        preguntaDesc69.Respuesta3 = NSLocalizedString("pregunta69.Respuesta3", comment: "")
        preguntaDesc69.Respuesta4 = NSLocalizedString("pregunta69.Respuesta4", comment: "")
        
        let pregunta70 = Pregunta()
        let preguntaDesc70 = PreguntaDescriptionLocalization()
        preguntaDesc70.pregunta = NSLocalizedString("pregunta70.pregunta", comment: "")
        pregunta70.RespuestaCorrecta = "4"
        pregunta70.IDRespuesta = "70"
        preguntaDesc70.IDRespuesta = "70"
        preguntaDesc70.Respuesta1 = NSLocalizedString("pregunta70.Respuesta1", comment: "")
        preguntaDesc70.Respuesta2 = NSLocalizedString("pregunta70.Respuesta2", comment: "")
        preguntaDesc70.Respuesta3 = NSLocalizedString("pregunta70.Respuesta3", comment: "")
        preguntaDesc70.Respuesta4 = NSLocalizedString("pregunta70.Respuesta4", comment: "")
        
        let pregunta71 = Pregunta()
        let preguntaDesc71 = PreguntaDescriptionLocalization()
        preguntaDesc71.pregunta = NSLocalizedString("pregunta71.pregunta", comment: "")
        pregunta71.RespuestaCorrecta = "4"
        pregunta71.IDRespuesta = "71"
        preguntaDesc71.IDRespuesta = "71"
        preguntaDesc71.Respuesta1 = NSLocalizedString("pregunta71.Respuesta1", comment: "")
        preguntaDesc71.Respuesta2 = NSLocalizedString("pregunta71.Respuesta2", comment: "")
        preguntaDesc71.Respuesta3 = NSLocalizedString("pregunta71.Respuesta3", comment: "")
        preguntaDesc71.Respuesta4 = NSLocalizedString("pregunta71.Respuesta4", comment: "")
        
        let pregunta72 = Pregunta()
        let preguntaDesc72 = PreguntaDescriptionLocalization()
        preguntaDesc72.pregunta = NSLocalizedString("pregunta72.pregunta", comment: "")
        pregunta72.RespuestaCorrecta = "4"
        pregunta72.IDRespuesta = "72"
        preguntaDesc72.IDRespuesta = "72"
        preguntaDesc72.Respuesta1 = NSLocalizedString("pregunta72.Respuesta1", comment: "")
        preguntaDesc72.Respuesta2 = NSLocalizedString("pregunta72.Respuesta2", comment: "")
        preguntaDesc72.Respuesta3 = NSLocalizedString("pregunta72.Respuesta3", comment: "")
        preguntaDesc72.Respuesta4 = NSLocalizedString("pregunta72.Respuesta4", comment: "")
        
        let pregunta73 = Pregunta()
        let preguntaDesc73 = PreguntaDescriptionLocalization()
        preguntaDesc73.pregunta = NSLocalizedString("pregunta73.pregunta", comment: "")
        pregunta73.RespuestaCorrecta = "4"
        pregunta73.IDRespuesta = "73"
        preguntaDesc73.IDRespuesta = "73"
        preguntaDesc73.Respuesta1 = NSLocalizedString("pregunta73.Respuesta1", comment: "")
        preguntaDesc73.Respuesta2 = NSLocalizedString("pregunta73.Respuesta2", comment: "")
        preguntaDesc73.Respuesta3 = NSLocalizedString("pregunta73.Respuesta3", comment: "")
        preguntaDesc73.Respuesta4 = NSLocalizedString("pregunta73.Respuesta4", comment: "")
        
        let pregunta74 = Pregunta()
        let preguntaDesc74 = PreguntaDescriptionLocalization()
        preguntaDesc74.pregunta = NSLocalizedString("pregunta74.pregunta", comment: "")
        pregunta74.RespuestaCorrecta = "4"
        pregunta74.IDRespuesta = "74"
        preguntaDesc74.IDRespuesta = "74"
        preguntaDesc74.Respuesta1 = NSLocalizedString("pregunta74.Respuesta1", comment: "")
        preguntaDesc74.Respuesta2 = NSLocalizedString("pregunta74.Respuesta2", comment: "")
        preguntaDesc74.Respuesta3 = NSLocalizedString("pregunta74.Respuesta3", comment: "")
        preguntaDesc74.Respuesta4 = NSLocalizedString("pregunta74.Respuesta4", comment: "")
        
        let pregunta75 = Pregunta()
        let preguntaDesc75 = PreguntaDescriptionLocalization()
        preguntaDesc75.pregunta = NSLocalizedString("pregunta75.pregunta", comment: "")
        pregunta75.RespuestaCorrecta = "4"
        pregunta75.IDRespuesta = "75"
        preguntaDesc75.IDRespuesta = "75"
        preguntaDesc75.Respuesta1 = NSLocalizedString("pregunta75.Respuesta1", comment: "")
        preguntaDesc75.Respuesta2 = NSLocalizedString("pregunta75.Respuesta2", comment: "")
        preguntaDesc75.Respuesta3 = NSLocalizedString("pregunta75.Respuesta3", comment: "")
        preguntaDesc75.Respuesta4 = NSLocalizedString("pregunta75.Respuesta4", comment: "")
        
        let pregunta76 = Pregunta()
        let preguntaDesc76 = PreguntaDescriptionLocalization()
        preguntaDesc76.pregunta = NSLocalizedString("pregunta76.pregunta", comment: "")
        pregunta76.RespuestaCorrecta = "4"
        pregunta76.IDRespuesta = "76"
        preguntaDesc76.IDRespuesta = "76"
        preguntaDesc76.Respuesta1 = NSLocalizedString("pregunta76.Respuesta1", comment: "")
        preguntaDesc76.Respuesta2 = NSLocalizedString("pregunta76.Respuesta2", comment: "")
        preguntaDesc76.Respuesta3 = NSLocalizedString("pregunta76.Respuesta3", comment: "")
        preguntaDesc76.Respuesta4 = NSLocalizedString("pregunta76.Respuesta4", comment: "")
        
        let pregunta77 = Pregunta()
        let preguntaDesc77 = PreguntaDescriptionLocalization()
        preguntaDesc77.pregunta = NSLocalizedString("pregunta77.pregunta", comment: "")
        pregunta77.RespuestaCorrecta = "4"
        pregunta77.IDRespuesta = "77"
        preguntaDesc77.IDRespuesta = "77"
        preguntaDesc77.Respuesta1 = NSLocalizedString("pregunta77.Respuesta1", comment: "")
        preguntaDesc77.Respuesta2 = NSLocalizedString("pregunta77.Respuesta2", comment: "")
        preguntaDesc77.Respuesta3 = NSLocalizedString("pregunta77.Respuesta3", comment: "")
        preguntaDesc77.Respuesta4 = NSLocalizedString("pregunta77.Respuesta4", comment: "")
        
        let pregunta78 = Pregunta()
        let preguntaDesc78 = PreguntaDescriptionLocalization()
        preguntaDesc78.pregunta = NSLocalizedString("pregunta78.pregunta", comment: "")
        pregunta78.RespuestaCorrecta = "4"
        pregunta78.IDRespuesta = "78"
        preguntaDesc78.IDRespuesta = "78"
        preguntaDesc78.Respuesta1 = NSLocalizedString("pregunta78.Respuesta1", comment: "")
        preguntaDesc78.Respuesta2 = NSLocalizedString("pregunta78.Respuesta2", comment: "")
        preguntaDesc78.Respuesta3 = NSLocalizedString("pregunta78.Respuesta3", comment: "")
        preguntaDesc78.Respuesta4 = NSLocalizedString("pregunta78.Respuesta4", comment: "")
        
        let pregunta79 = Pregunta()
        let preguntaDesc79 = PreguntaDescriptionLocalization()
        preguntaDesc79.pregunta = NSLocalizedString("pregunta79.pregunta", comment: "")
        pregunta79.RespuestaCorrecta = "4"
        pregunta79.IDRespuesta = "79"
        preguntaDesc79.IDRespuesta = "79"
        preguntaDesc79.Respuesta1 = NSLocalizedString("pregunta79.Respuesta1", comment: "")
        preguntaDesc79.Respuesta2 = NSLocalizedString("pregunta79.Respuesta2", comment: "")
        preguntaDesc79.Respuesta3 = NSLocalizedString("pregunta79.Respuesta3", comment: "")
        preguntaDesc79.Respuesta4 = NSLocalizedString("pregunta79.Respuesta4", comment: "")
        
        let pregunta80 = Pregunta()
        let preguntaDesc80 = PreguntaDescriptionLocalization()
        preguntaDesc80.pregunta = NSLocalizedString("pregunta80.pregunta", comment: "")
        pregunta80.RespuestaCorrecta = "4"
        pregunta80.IDRespuesta = "80"
        preguntaDesc80.IDRespuesta = "80"
        preguntaDesc80.Respuesta1 = NSLocalizedString("pregunta80.Respuesta1", comment: "")
        preguntaDesc80.Respuesta2 = NSLocalizedString("pregunta80.Respuesta2", comment: "")
        preguntaDesc80.Respuesta3 = NSLocalizedString("pregunta80.Respuesta3", comment: "")
        preguntaDesc80.Respuesta4 = NSLocalizedString("pregunta80.Respuesta4", comment: "")
        
        let pregunta81 = Pregunta()
        let preguntaDesc81 = PreguntaDescriptionLocalization()
        preguntaDesc81.pregunta = NSLocalizedString("pregunta81.pregunta", comment: "")
        pregunta81.RespuestaCorrecta = "4"
        pregunta81.IDRespuesta = "81"
        preguntaDesc81.IDRespuesta = "81"
        preguntaDesc81.Respuesta1 = NSLocalizedString("pregunta81.Respuesta1", comment: "")
        preguntaDesc81.Respuesta2 = NSLocalizedString("pregunta81.Respuesta2", comment: "")
        preguntaDesc81.Respuesta3 = NSLocalizedString("pregunta81.Respuesta3", comment: "")
        preguntaDesc81.Respuesta4 = NSLocalizedString("pregunta81.Respuesta4", comment: "")
        
        let pregunta82 = Pregunta()
        let preguntaDesc82 = PreguntaDescriptionLocalization()
        preguntaDesc82.pregunta = NSLocalizedString("pregunta82.pregunta", comment: "")
        pregunta82.RespuestaCorrecta = "4"
        pregunta82.IDRespuesta = "82"
        preguntaDesc82.IDRespuesta = "82"
        preguntaDesc82.Respuesta1 = NSLocalizedString("pregunta82.Respuesta1", comment: "")
        preguntaDesc82.Respuesta2 = NSLocalizedString("pregunta82.Respuesta2", comment: "")
        preguntaDesc82.Respuesta3 = NSLocalizedString("pregunta82.Respuesta3", comment: "")
        preguntaDesc82.Respuesta4 = NSLocalizedString("pregunta82.Respuesta4", comment: "")
        
        let pregunta83 = Pregunta()
        let preguntaDesc83 = PreguntaDescriptionLocalization()
        preguntaDesc83.pregunta = NSLocalizedString("pregunta83.pregunta", comment: "")
        pregunta83.RespuestaCorrecta = "4"
        pregunta83.IDRespuesta = "83"
        preguntaDesc83.IDRespuesta = "83"
        preguntaDesc83.Respuesta1 = NSLocalizedString("pregunta83.Respuesta1", comment: "")
        preguntaDesc83.Respuesta2 = NSLocalizedString("pregunta83.Respuesta2", comment: "")
        preguntaDesc83.Respuesta3 = NSLocalizedString("pregunta83.Respuesta3", comment: "")
        preguntaDesc83.Respuesta4 = NSLocalizedString("pregunta83.Respuesta4", comment: "")
        
        
        
        let lstPreguntas = List<Pregunta>()
        
        lstPreguntas.append(pregunta1)
        lstPreguntas.append(pregunta2)
        lstPreguntas.append(pregunta3)
        lstPreguntas.append(pregunta4)
        lstPreguntas.append(pregunta5)
        lstPreguntas.append(pregunta6)
        lstPreguntas.append(pregunta7)
        lstPreguntas.append(pregunta8)
        lstPreguntas.append(pregunta9)
        lstPreguntas.append(pregunta10)
        lstPreguntas.append(pregunta11)
        lstPreguntas.append(pregunta12)
        lstPreguntas.append(pregunta13)
        lstPreguntas.append(pregunta14)
        lstPreguntas.append(pregunta15)
        lstPreguntas.append(pregunta16)
        lstPreguntas.append(pregunta17)
        lstPreguntas.append(pregunta18)
        lstPreguntas.append(pregunta19)
        lstPreguntas.append(pregunta20)
        lstPreguntas.append(pregunta21)
        lstPreguntas.append(pregunta22)
        lstPreguntas.append(pregunta23)
        lstPreguntas.append(pregunta24)
        lstPreguntas.append(pregunta25)
        lstPreguntas.append(pregunta26)
        lstPreguntas.append(pregunta27)
        lstPreguntas.append(pregunta28)
        lstPreguntas.append(pregunta29)
        lstPreguntas.append(pregunta30)
        lstPreguntas.append(pregunta31)
        lstPreguntas.append(pregunta32)
        lstPreguntas.append(pregunta33)
        lstPreguntas.append(pregunta34)
        lstPreguntas.append(pregunta35)
        lstPreguntas.append(pregunta36)
        lstPreguntas.append(pregunta37)
        lstPreguntas.append(pregunta38)
        lstPreguntas.append(pregunta39)
        lstPreguntas.append(pregunta40)
        lstPreguntas.append(pregunta41)
        lstPreguntas.append(pregunta42)
        lstPreguntas.append(pregunta43)
        lstPreguntas.append(pregunta44)
        lstPreguntas.append(pregunta45)
        lstPreguntas.append(pregunta46)
        lstPreguntas.append(pregunta47)
        lstPreguntas.append(pregunta48)
        lstPreguntas.append(pregunta49)
        lstPreguntas.append(pregunta50)
        lstPreguntas.append(pregunta51)
        lstPreguntas.append(pregunta52)
        lstPreguntas.append(pregunta53)
        lstPreguntas.append(pregunta54)
        lstPreguntas.append(pregunta55)
        lstPreguntas.append(pregunta56)
        lstPreguntas.append(pregunta57)
        lstPreguntas.append(pregunta58)
        lstPreguntas.append(pregunta59)
        lstPreguntas.append(pregunta60)
        lstPreguntas.append(pregunta61)
        lstPreguntas.append(pregunta62)
        lstPreguntas.append(pregunta63)
        lstPreguntas.append(pregunta64)
        lstPreguntas.append(pregunta65)
        lstPreguntas.append(pregunta66)
        lstPreguntas.append(pregunta67)
        lstPreguntas.append(pregunta68)
        lstPreguntas.append(pregunta69)
        lstPreguntas.append(pregunta70)
        lstPreguntas.append(pregunta71)
        lstPreguntas.append(pregunta72)
        lstPreguntas.append(pregunta73)
        lstPreguntas.append(pregunta74)
        lstPreguntas.append(pregunta75)
        lstPreguntas.append(pregunta76)
        lstPreguntas.append(pregunta77)
        lstPreguntas.append(pregunta78)
        lstPreguntas.append(pregunta79)
        lstPreguntas.append(pregunta80)
        lstPreguntas.append(pregunta81)
        lstPreguntas.append(pregunta82)
        lstPreguntas.append(pregunta83)
        
        preguntasDescription.append(preguntaDesc1)
        preguntasDescription.append(preguntaDesc2)
        preguntasDescription.append(preguntaDesc3)
        preguntasDescription.append(preguntaDesc4)
        preguntasDescription.append(preguntaDesc5)
        preguntasDescription.append(preguntaDesc6)
        preguntasDescription.append(preguntaDesc7)
        preguntasDescription.append(preguntaDesc8)
        preguntasDescription.append(preguntaDesc9)
        preguntasDescription.append(preguntaDesc10)
        preguntasDescription.append(preguntaDesc11)
        preguntasDescription.append(preguntaDesc12)
        preguntasDescription.append(preguntaDesc13)
        preguntasDescription.append(preguntaDesc14)
        preguntasDescription.append(preguntaDesc15)
        preguntasDescription.append(preguntaDesc16)
        preguntasDescription.append(preguntaDesc17)
        preguntasDescription.append(preguntaDesc18)
        preguntasDescription.append(preguntaDesc19)
        preguntasDescription.append(preguntaDesc20)
        preguntasDescription.append(preguntaDesc21)
        preguntasDescription.append(preguntaDesc22)
        preguntasDescription.append(preguntaDesc23)
        preguntasDescription.append(preguntaDesc24)
        preguntasDescription.append(preguntaDesc25)
        preguntasDescription.append(preguntaDesc26)
        preguntasDescription.append(preguntaDesc27)
        preguntasDescription.append(preguntaDesc28)
        preguntasDescription.append(preguntaDesc29)
        preguntasDescription.append(preguntaDesc30)
        preguntasDescription.append(preguntaDesc31)
        preguntasDescription.append(preguntaDesc32)
        preguntasDescription.append(preguntaDesc33)
        preguntasDescription.append(preguntaDesc34)
        preguntasDescription.append(preguntaDesc35)
        preguntasDescription.append(preguntaDesc36)
        preguntasDescription.append(preguntaDesc37)
        preguntasDescription.append(preguntaDesc38)
        preguntasDescription.append(preguntaDesc39)
        preguntasDescription.append(preguntaDesc40)
        preguntasDescription.append(preguntaDesc41)
        preguntasDescription.append(preguntaDesc42)
        preguntasDescription.append(preguntaDesc43)
        preguntasDescription.append(preguntaDesc44)
        preguntasDescription.append(preguntaDesc45)
        preguntasDescription.append(preguntaDesc46)
        preguntasDescription.append(preguntaDesc47)
        preguntasDescription.append(preguntaDesc48)
        preguntasDescription.append(preguntaDesc49)
        preguntasDescription.append(preguntaDesc50)
        preguntasDescription.append(preguntaDesc51)
        preguntasDescription.append(preguntaDesc52)
        preguntasDescription.append(preguntaDesc53)
        preguntasDescription.append(preguntaDesc54)
        preguntasDescription.append(preguntaDesc55)
        preguntasDescription.append(preguntaDesc56)
        preguntasDescription.append(preguntaDesc57)
        preguntasDescription.append(preguntaDesc58)
        preguntasDescription.append(preguntaDesc59)
        preguntasDescription.append(preguntaDesc60)
        preguntasDescription.append(preguntaDesc61)
        preguntasDescription.append(preguntaDesc62)
        preguntasDescription.append(preguntaDesc63)
        preguntasDescription.append(preguntaDesc64)
        preguntasDescription.append(preguntaDesc65)
        preguntasDescription.append(preguntaDesc66)
        preguntasDescription.append(preguntaDesc67)
        preguntasDescription.append(preguntaDesc68)
        preguntasDescription.append(preguntaDesc69)
        preguntasDescription.append(preguntaDesc70)
        preguntasDescription.append(preguntaDesc71)
        preguntasDescription.append(preguntaDesc72)
        preguntasDescription.append(preguntaDesc73)
        preguntasDescription.append(preguntaDesc74)
        preguntasDescription.append(preguntaDesc75)
        preguntasDescription.append(preguntaDesc76)
        preguntasDescription.append(preguntaDesc77)
        preguntasDescription.append(preguntaDesc78)
        preguntasDescription.append(preguntaDesc79)
        preguntasDescription.append(preguntaDesc80)
        preguntasDescription.append(preguntaDesc81)
        preguntasDescription.append(preguntaDesc82)
        preguntasDescription.append(preguntaDesc83)

        self.tableViewPreguntas.reloadData()
        return lstPreguntas
    }
    
    
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
                    for des in preguntasDescription{
                        if des.IDRespuesta == pregunta.IDRespuesta{
                            if let index = preguntasDescription.index(of: des) {
                                preguntasDescription.remove(at: index)
                            }
                        }
                }
                realm.delete(objectsToDelete)
                tableViewPreguntas.reloadData()
            }
        } catch {
        }
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }
    }
    
    //    MARK: - Eventos
    
    //    MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func anadirPreguntasContestadas(preguntaContestada: PreguntaDescriptionLocalization, identBoton : String) ->Pregunta{
        let idPregunta: String = preguntaContestada.IDRespuesta
        var respBuena = ""
        for pregunta in preguntas{
            if (preguntaContestada.IDRespuesta == pregunta.IDRespuesta){
                respBuena = pregunta.RespuestaCorrecta
            }
        }
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
        let pregunta:Pregunta! = nil
        if preguntas.count <= 0 {
            performSegue(withIdentifier: "segueComprobar", sender: nil)
        }else{
            for pregunta in preguntas{
                if (preguntaContestada.IDRespuesta == pregunta.IDRespuesta){
                    return pregunta
                }
            }
        }
        return pregunta
    }
    
    func buscarPreguntaContestada(){
        
    }
}

//    MARK: - Extension cell delegate
extension NerdAcademyQuizViewController : PreguntaCellDelegate
{
    func didBtnRespuesta1(pregunta: PreguntaDescriptionLocalization, indexSeleccionado: IndexPath) {
        let pregunta = anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "1")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta2(pregunta: PreguntaDescriptionLocalization, indexSeleccionado: IndexPath) {
        let pregunta = anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "2")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta3(pregunta: PreguntaDescriptionLocalization, indexSeleccionado: IndexPath) {
        let pregunta = anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "3")
        PreguntaMarcada(pregunta)
    }
    
    func didBtnRespuesta4(pregunta: PreguntaDescriptionLocalization, indexSeleccionado: IndexPath) {
        let pregunta = anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "4")
        PreguntaMarcada(pregunta)
    }
    //
    //
    //    func didBtnRespuesta1(pregunta: Pregunta, indexSeleccionado: IndexPath) {
    ////        NSLog("%@ buton%@", pregunta.pregunta, "btn 1")
    //        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "1")
    //        PreguntaMarcada(pregunta)
    //    }
    //
    //    func didBtnRespuesta2(pregunta: Pregunta, indexSeleccionado: IndexPath) {
    ////        NSLog("%@ buton%@", pregunta.pregunta, "btn 2")
    //        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "2")
    //        PreguntaMarcada(pregunta)
    //    }
    //
    //    func didBtnRespuesta3(pregunta: Pregunta, indexSeleccionado: IndexPath) {
    ////        NSLog("%@ buton%@", pregunta.pregunta, "btn 3")
    //        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "3")
    //        PreguntaMarcada(pregunta)
    //    }
    //
    //    func didBtnRespuesta4(pregunta: Pregunta, indexSeleccionado: IndexPath) {
    ////        NSLog("%@ buton%@", pregunta.pregunta, "btn 4")
    //        anadirPreguntasContestadas(preguntaContestada: pregunta, identBoton: "4")
    //        PreguntaMarcada(pregunta)
    //    }
    //
    
}
