//
//  PreguntaTableViewCell.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 22/4/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

protocol PreguntaCellDelegate {
    func didBtnRespuesta1(pregunta :NSMutableDictionary)
    func didBtnRespuesta2(pregunta :NSMutableDictionary)
    func didBtnRespuesta3(pregunta :NSMutableDictionary)
    func didBtnRespuesta4(pregunta :NSMutableDictionary)
}

class PreguntaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPregunta: UILabel!
    @IBOutlet weak var btnRespuesta1: UIButton!
    @IBOutlet weak var btnRespuesta2: UIButton!
    @IBOutlet weak var btnRespuesta3: UIButton!
    @IBOutlet weak var btnRespuesta4: UIButton!
    var pregunta = NSMutableDictionary()
    var delegate: PreguntaCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cargarPregunta(pregunta : NSMutableDictionary){
        self.pregunta = pregunta
        lblPregunta.text = pregunta["lblPregunta"] as? String
        btnRespuesta1.setTitle(pregunta["resp1"] as? String, for:UIControlState.normal)
        btnRespuesta2.setTitle(pregunta["resp2"] as? String, for:UIControlState.normal)
        btnRespuesta3.setTitle(pregunta["resp3"] as? String, for:UIControlState.normal)
        btnRespuesta4.setTitle(pregunta["resp4"] as? String, for:UIControlState.normal)
    }
    
    @IBAction func btnRespuesta1(_ sender: Any) {
        delegate?.didBtnRespuesta1(pregunta: self.pregunta)
    }
    
    @IBAction func btnRespuesta2(_ sender: Any) {
    }

    @IBAction func btnRespuesta3(_ sender: Any) {
    }

    @IBAction func btnRespuesta4(_ sender: Any) {
    }

    
    
    
    
}
