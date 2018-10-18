//
//  MangaViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 10/17/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import WebKit

class MangaViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://www.youtube.com/embed?listType=playlist&list=PL5KuHZ5qoFrSiHEiKLARcdAjr7zlUbDmq") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
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






