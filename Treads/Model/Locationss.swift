//
//  Locationss.swift
//  Treads
//
//  Created by Amr on 12/19/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import Foundation
import RealmSwift

class Locationss: Object {
    dynamic public private(set) var latitude = 0.0
    dynamic public private(set) var longitude = 0.0

    convenience init(latitude: Double, longitude: Double){
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
