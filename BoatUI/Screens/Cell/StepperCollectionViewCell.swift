//
//  StepperCollectionViewCell.swift
//  BoatUI
//
//  Created by NeoSOFT on 27/11/23.
//

import UIKit

class StepperCollectionViewCell: UICollectionViewCell {
    
    //MARK: -  IBOutlets
    @IBOutlet weak var verticalSlider: VSSlider!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

//MARK: cellSetup method
extension StepperCollectionViewCell {
    func setDataValue(value: Int) {
        if value >= 1000 {
        // If the value is greater than or equal to 1000, format it as "1K", "2K", etc.
        let formattedValue = String(format: "%.0fK", Double(value) / 1000.0)
                valueLabel.text = formattedValue
        } else {
            // Otherwise, just display the numeric value
            valueLabel.text = "\(value)"
        }
    }
    func setData(){
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
}



