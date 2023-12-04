//
//  ViewController.swift
//  BoatUI
//
//  Created by NeoSOFT on 27/11/23.
//

import UIKit

fileprivate struct cellIdentifier {
    static let  stepperCollectioncellIdentifier  = "StepperCollectionViewCell"
    static let  SoundPresetsCollectionCelldentifier  = "SoundPresetsCollectionViewCell"

    
}

class SoundSettingViewController: UIViewController {
    
    @IBOutlet weak var presetCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
  //  @IBOutlet var buttons: [UIButton]!
    
    // MARK: -  labelValues of Equilizer Graph
    let labelValues = [32,64,128,256,512,1024,2048,4096]
    
    // MARK: -  Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOfCollectionViewCell()
        //self.updateUI(with: 1)
    }
}

//MARK: Button Action
//extension SoundSettingViewController {
//    @IBAction func buttonTapped(_ sender: UIButton) {
//        //  Access the tag to determine which button was tapped
//        self.updateUI(with: sender.tag)
//    }
//}

//MARK: Custom methods
extension SoundSettingViewController {
//    func updateUI(with tag: Int) {
//        // Perform actions based on the button tapped
//        for button in buttons {
//            if button.tag == tag {
//                button.layer.cornerRadius = 18.0
//                button.layer.borderColor = UIColor.red.cgColor
//                button.setTitleColor(.white, for: .normal)
//                button.layer.borderWidth = 1
//                button.backgroundColor = .darkGray.withAlphaComponent(0.8)
//            } else {
//                button.setTitleColor(.white, for: .normal)
//                button.layer.borderWidth = 0
//                button.setTitleColor(.gray, for: .normal)
//                button.backgroundColor = .clear
//            }
//        }
//    }
    
    func setUpOfCollectionViewCell(){
        // Register the custom cell class
        let nib = UINib(nibName: cellIdentifier.stepperCollectioncellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier.stepperCollectioncellIdentifier)
        
        let presetButtonnib = UINib(nibName: cellIdentifier.SoundPresetsCollectionCelldentifier, bundle: nil)
        presetCollectionView.register(presetButtonnib, forCellWithReuseIdentifier: cellIdentifier.SoundPresetsCollectionCelldentifier)
        
        // Set the data source and delegate (you need to implement UICollectionViewDataSource methods)
        collectionView.dataSource = self
        collectionView.delegate = self
        presetCollectionView.dataSource = self
        presetCollectionView.delegate = self
        // Set the collection view layout
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        presetCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
    }
    
}

//MARK: -  Collection view delegate datasource
extension SoundSettingViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // Implement UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in your collection view
        if section == 0 {
            return 3
        }
        else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue and configure your custom cell
        if indexPath.section == 0 {
            let cell = presetCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.SoundPresetsCollectionCelldentifier, for: indexPath) as! SoundPresetsCollectionViewCell
            cell.setTitle(index: indexPath.item)
            cell.presetButton.tag = indexPath.item
            cell.soundpresentdelegate = self
            
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.stepperCollectioncellIdentifier, for: indexPath) as! StepperCollectionViewCell
            cell.setData()
            cell.setDataValue(value: labelValues[indexPath.item])
            return cell
        }
        
    }
    
    // Implement UICollectionViewDelegateFlowLayout method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size of each item (you can customize this per item if needed)
        if indexPath.section == 0 {
            return CGSize(width: 123, height: 38)
        }
        else {
            return CGSize(width: 43, height: 240)
        }
    
    }
}



extension SoundSettingViewController :SoundPresentDelegate {
    func didTapButton(index: Int) {
        
    }
    
    
}
