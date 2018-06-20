//
//  PreguntaTableViewCell.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 22/4/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit


protocol PreguntaCellDelegate {
    func didBtnRespuesta1(pregunta :PreguntaDescriptionLocalization, indexSeleccionado :IndexPath)
    func didBtnRespuesta2(pregunta :PreguntaDescriptionLocalization, indexSeleccionado :IndexPath)
    func didBtnRespuesta3(pregunta :PreguntaDescriptionLocalization, indexSeleccionado :IndexPath)
    func didBtnRespuesta4(pregunta :PreguntaDescriptionLocalization, indexSeleccionado :IndexPath)
}

class PreguntaTableViewCell: UITableViewCell {
    
    var shouldSelectRow: IndexPath = []
    
    @IBOutlet weak var lblPregunta: UILabel!
    @IBOutlet weak var btnRespuesta1: UIButton!
    @IBOutlet weak var btnRespuesta2: UIButton!
    @IBOutlet weak var btnRespuesta3: UIButton!
    @IBOutlet weak var btnRespuesta4: UIButton!
    
    var pregunta: PreguntaDescriptionLocalization!
    var delegate: PreguntaCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    func cargarPregunta(pregunta : Pregunta){
    //        self.pregunta = pregunta
    //        lblPregunta.text = pregunta.pregunta
    //        btnRespuesta1.setTitle(pregunta.Respuesta1, for:UIControlState.normal)
    //        btnRespuesta2.setTitle(pregunta.Respuesta2, for:UIControlState.normal)
    //        btnRespuesta3.setTitle(pregunta.Respuesta3, for:UIControlState.normal)
    //        btnRespuesta4.setTitle(pregunta.Respuesta4, for:UIControlState.normal)
    //    }
    func cargarPregunta(pregunta : PreguntaDescriptionLocalization){
        self.pregunta = pregunta
        lblPregunta.text = pregunta.pregunta
        btnRespuesta1.setTitle(pregunta.Respuesta1, for:UIControlState.normal)
        btnRespuesta2.setTitle(pregunta.Respuesta2, for:UIControlState.normal)
        btnRespuesta3.setTitle(pregunta.Respuesta3, for:UIControlState.normal)
        btnRespuesta4.setTitle(pregunta.Respuesta4, for:UIControlState.normal)
    }
    
    //    PreguntaDescriptionLocalization
    
    @IBAction func btnRespuesta1(_ sender: Any) {
        delegate?.didBtnRespuesta1(pregunta: self.pregunta, indexSeleccionado: shouldSelectRow)
    }
    
    @IBAction func btnRespuesta2(_ sender: Any) {
        delegate?.didBtnRespuesta2(pregunta: self.pregunta, indexSeleccionado: shouldSelectRow)
        
    }
    
    @IBAction func btnRespuesta3(_ sender: Any) {
        delegate?.didBtnRespuesta3(pregunta: self.pregunta, indexSeleccionado: shouldSelectRow)
        
    }
    
    @IBAction func btnRespuesta4(_ sender: Any) {
        delegate?.didBtnRespuesta4(pregunta: self.pregunta, indexSeleccionado: shouldSelectRow)
        
    }
}

