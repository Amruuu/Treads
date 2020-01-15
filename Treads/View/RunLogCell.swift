//
//  RunLogCell.swift
//  Treads
//
//  Created by Amr on 12/14/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var avgPaceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(Run: Run){
        runDurationLbl.text = Run.duration.FormatTimeDurationToString()
        totalDistance.text = "\(Run.distance.MetersToKilo(DecimalPlaces: 2)) K"
        avgPaceLbl.text = Run.pace.FormatTimeDurationToString()
        dateLbl.text = Run.date.getDateString()
    }

}
