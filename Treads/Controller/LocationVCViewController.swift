//
//  LocationVCViewController.swift
//  Treads
//
//  Created by Amr on 11/21/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import UIKit
import MapKit

class LocationVCViewController: UIViewController, MKMapViewDelegate {

    var manager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
    }
    
    func CheckLocationAuthSataus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
            manager?.requestWhenInUseAuthorization()
        }
        
    }

    

}
