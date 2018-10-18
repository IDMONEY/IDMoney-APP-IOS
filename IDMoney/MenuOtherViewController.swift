//
//  MenuOtherViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 10/15/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class MenuOtherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuOtherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")!
            cell.textLabel?.text = "LAMBO"
            cell.textLabel?.textColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")!
            cell.textLabel?.text = "IDMoney Price"
            cell.textLabel?.textColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3")!
            cell.textLabel?.textColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
            cell.textLabel?.text = "IDMoney Global Map"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            
        }
    }
    
    
}
