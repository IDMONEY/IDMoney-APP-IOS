//
//  TipoPagoController.swift
//  Trok
//
//  Created by Administrator on 13/9/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import Foundation

class TipoPagoController: UITableViewController {
    
    var names = [String]()
    var identities = [String]()
    //let list = ["Tarjeta Crédito", "Paypal"]
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = names[indexPath.row]
        
        return cell!
    }
    
    
    override func viewDidLoad() {
        names = ["Tarjeta Crédito / Débito"]
        identities = ["A", "B", "C", "D"]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
   
    
    
}
