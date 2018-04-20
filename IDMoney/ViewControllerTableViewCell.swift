//
//  ViewControllerTableViewCell.swift
//  Trok
//
//  Created by Administrator on 12/3/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var viajeImage: UIImageView!
    @IBOutlet weak var lblFechaHora: UILabel!
    @IBOutlet weak var lblMonto: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
