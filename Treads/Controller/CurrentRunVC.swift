//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Amr on 11/22/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class CurrentRunVC: LocationVCViewController {
    // slideeeeer button
    @IBOutlet weak var swipeBGimageView: UIImageView!
    @IBOutlet weak var sliderImageView: UIImageView!
    // other outlets
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    //for timer
    var counter = 0
    var timer = Timer()
    //for distance
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var runDistane = 0.0
    //for pace
    var pace = 0
    //
    var ourlocations = List<Locationss>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(SwipeToEndRun(sender:)))
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    func startRun() {
       pauseBtn.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
       manager?.startUpdatingLocation()
       startTimer()
    }
    func endRun() {
        manager?.stopUpdatingLocation()
        //Add our object to realm
        Run.addRunToRealm(duration: counter, pace: pace, distance: runDistane, locations: ourlocations)
    }
    func PauseRun(){
        self.pauseBtn.setImage(#imageLiteral(resourceName: "resumeButton"), for: .normal)
        startLocation = nil
        lastLocation = nil
        timer.invalidate()
        manager?.stopUpdatingLocation()
    }
    func startTimer(){
        durationLabel.text = counter.FormatTimeDurationToString()
        //timeInterval = the no. of sec
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateCounter), userInfo: nil, repeats: true)
    }
    @objc func UpdateCounter(){
        counter += 1
        durationLabel.text = counter.FormatTimeDurationToString()
    }
    func CalculatePace(time seconds: Int, kiloMeters: Double) -> String{
        pace = Int(Double(seconds) / kiloMeters)
        return pace.FormatTimeDurationToString()
    }
    @IBAction func PressedThePauseBtn(_ sender: Any) {
        if timer.isValid{
            PauseRun()
        }else{
            startRun()
        }
    }
    @objc func SwipeToEndRun(sender: UIPanGestureRecognizer){
        let minAdjust: CGFloat = 85
        let maxAdjust: CGFloat = 125
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
     if sliderView.center.x >= (swipeBGimageView.center.x - minAdjust) && sliderView.center.x <= (swipeBGimageView.center.x + maxAdjust){
                    sliderView.center.x = sliderView.center.x + translation.x
               }else if sliderView.center.x >= (swipeBGimageView.center.x + maxAdjust){
                    sliderView.center.x = swipeBGimageView.center.x + maxAdjust
                    //End Run code
                    endRun()
                    dismiss(animated: true, completion: nil)
               }else{
                     sliderView.center.x = swipeBGimageView.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.swipeBGimageView.center.x - minAdjust
                }
            }
        }
    }
}

extension CurrentRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            CheckLocationAuthSataus()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil{
            startLocation = locations.first
        }else if let llocation = locations.last {
           runDistane += lastLocation.distance(from: llocation)
            let newLocation = Locationss(latitude: Double(lastLocation.coordinate.latitude), longitude: Double(lastLocation.coordinate.longitude))
            ourlocations.insert(newLocation, at: 0)
           distanceLabel.text = "\(runDistane.MetersToKilo(DecimalPlaces: 2))"
           if counter > 0 && runDistane > 0 {
                paceLabel.text = CalculatePace(time: counter, kiloMeters: runDistane.MetersToKilo(DecimalPlaces: 2))
            }
        }
        lastLocation = locations.last
    }
    
}
