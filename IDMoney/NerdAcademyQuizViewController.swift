//
//  NerdAcademyQuizViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 22/4/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class NerdAcademyQuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewPreguntas: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPreguntas.register(UINib(nibName: "PreguntaTableViewCell", bundle: nil), forCellReuseIdentifier: "cellPreguntas")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PreguntaTableViewCell = tableViewPreguntas.dequeueReusableCell(withIdentifier: "cellPreguntas", for: indexPath) as! PreguntaTableViewCell
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return array.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueComprobar", sender: self)
    }
    
    
    //    MARK: - Metodos

    //    MARK: - Eventos
    
    //    MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
