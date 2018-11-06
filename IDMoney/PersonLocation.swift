//
//  PersonLocation.swift
//  IDMoney
//
//  Created by Luis Gutierrez on 11/1/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import GoogleMaps

class PersonLocation: GMSMarker {
    var uuid: String!
    init(uuid: String, position: CLLocationCoordinate2D) {
        super.init()
        self.uuid = uuid
        self.position = position
    }
}
