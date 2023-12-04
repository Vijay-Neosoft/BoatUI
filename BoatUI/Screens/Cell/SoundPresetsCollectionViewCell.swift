//
//  SoundPresetsCollectionViewCell.swift
//  BoatUI
//
//  Created by NeoSOFT on 28/11/23.
//

import UIKit

protocol SoundPresentDelegate:AnyObject{
    func didTapButton(index:Int)
}

class SoundPresetsCollectionViewCell: UICollectionViewCell {
    
    weak var soundpresentdelegate : SoundPresentDelegate?

    @IBOutlet weak var presetButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func  setTitle(index:Int){
        switch index {
        case 0 :
            presetButton.setTitle("Adaptive", for: .normal)
        case 1:
            presetButton.setTitle("Natural", for: .normal)
        case 2 :
            presetButton.setTitle("Movie", for: .normal)
        default:
            break
            
        }
    }

    @IBAction func presetButtonAction(_ sender: UIButton) {
        
        soundpresentdelegate?.didTapButton(index: sender.tag)
    }
}



