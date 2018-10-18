//
//  LaunchScreenViewController.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 10/17/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import SwiftyGif

class LaunchScreenViewController: UIViewController {

    let logoAnimationView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
}

extension LaunchScreenViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        performSegue(withIdentifier: "initApp", sender: nil)
    }
}
