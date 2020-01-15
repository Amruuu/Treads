//
//  extensions.swift
//  Treads
//
//  Created by Amr on 11/24/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import Foundation

extension Double {
    func MetersToKilo(DecimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(DecimalPlaces))
        return ((self / 1000) * divisor).rounded() / divisor
    }
}

extension Int {
    func FormatTimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMin = (self % 3600) / 60
        let durationSec = (self % 3600) % 60
        
        if durationSec < 0{
            return "00:00:00"
        }else {
            if durationHours == 0{
                return String(format: "%02d:%02d", durationMin, durationSec)
            }else{
                return String(format: "%02d:%02d:%02d", durationHours, durationMin, durationSec)
            }
        }
    }
}
extension NSDate {
    func getDateString() -> String {
        let calender = Calendar.current
        let month = calender.component(.month, from: self as Date)
        let day = calender.component(.day, from: self as Date)
        let year = calender.component(.year, from: self as Date)
        return "\(day)/\(month)/\(year)"
    }
}









