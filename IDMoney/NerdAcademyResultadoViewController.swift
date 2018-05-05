//
//  NerdAcademyResultadoViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 3/5/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import RealmSwift

class NerdAcademyResultadoViewController: UIViewController {

    @IBOutlet weak var ImgResultado: UIImageView!
    @IBOutlet weak var lblTipoResultado: UILabel!
    @IBOutlet weak var lblResultado: UILabel!
    @IBOutlet weak var lblLeyenda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true  
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var preguntasCorrectas : Int = 0
        var preguntasIncorrectas : Int = 0
        var totalPreguntas : Int = 0
        preguntasCorrectas = preguntasContestada.filter("preguntaCorrecta = 1").count
        preguntasIncorrectas = preguntasContestada.filter("preguntaCorrecta = 0").count
        totalPreguntas = preguntasContestada.count
        lblResultado.text = String(format: "%d/%d", preguntasCorrectas, totalPreguntas)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
