//
//  SoundPresetsCollectionViewCell.swift
//  BoatUI
//
//  Created by NeoSOFT on 28/11/23.
//

import UIKit

class SoundPresetsCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var presetButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSelectedButton(){
        presetButton.layer.cornerRadius = 18.0
        presetButton.layer.borderColor = UIColor.red.cgColor
        presetButton.setTitleColor(.white, for: .normal)
        presetButton.layer.borderWidth = 1
        presetButton.backgroundColor = .darkGray.withAlphaComponent(0.8)
    }
    
    func setUnSelectedButton(){
        presetButton.setTitleColor(.white, for: .normal)
        presetButton.layer.borderWidth = 0
        presetButton.setTitleColor(.gray, for: .normal)
        presetButton.backgroundColor = .clear
    }
}



