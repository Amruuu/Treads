//
//  BeginRunVC.swift
//  Treads
//
//  Created by Amr on 11/11/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVCViewController {

    @IBOutlet weak var Mapview: MKMapView!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    @IBOutlet weak var lastRunView: UIView!
    @IBOutlet weak var theInfoStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckLocationAuthSataus()
      // print("there are my runs : \(Run.getAllRuns()?.first)")
    }
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        Mapview.delegate = self
        manager?.startUpdatingLocation()
        //getLastRun()
    }
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    func setupMapView(){
        if let overlay = addLastRunToMap() {
            if Mapview.overlays.count > 0 {
                Mapview.removeOverlays(Mapview.overlays)
            }
            Mapview.addOverlay(overlay)
            lastRunView.isHidden = false
            theInfoStack.isHidden = false
            closeBtn.isHidden = false
        } else {
            lastRunView.isHidden = true
            theInfoStack.isHidden = true
            closeBtn.isHidden = true
        }
    }
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else { return nil }
        paceLbl.text = "\(lastRun.pace.FormatTimeDurationToString()) /k"
        durationLbl.text = lastRun.duration.FormatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.MetersToKilo(DecimalPlaces: 2)) k"
        var coordinateZ = [CLLocationCoordinate2D]()
        for loc in lastRun.locations {
            coordinateZ.append(CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude))
        }
        let OVERLAYY = MKPolyline(coordinates: coordinateZ, count: coordinateZ.count)
        return OVERLAYY
    }
   
    @IBAction func closeBtn(_ sender: Any) {
        lastRunView.isHidden = true
        theInfoStack.isHidden = true
        closeBtn.isHidden = true
    }
    @IBAction func LocationCenterBtn(_ sender: Any) {
    }
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            CheckLocationAuthSataus()
            Mapview.showsUserLocation = true
            Mapview.userTrackingMode = .follow
        }
    }

    func mapView(_ mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            //polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
}


//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//       // let polyline = overlay as! MKPolyline
//       //let renderer = MKPolylineRenderer(polyline: polyline)
//        let polyline = overlay
//        let renderer = MKPolylineRenderer(overlay: polyline)
//        renderer.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//        renderer.lineWidth = 4
//        return renderer
//
////        if (overlay is MKPolyline){
////            let renderer = MKPolylineRenderer(overlay: overlay)
////            renderer.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
////            renderer.lineWidth = 5
////            return renderer
////        }
////        return MKOverlayRenderer()
////    }


