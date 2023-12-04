//
//  ViewController.swift
//  BoatUI
//
//  Created by NeoSOFT on 27/11/23.
//

import UIKit

fileprivate struct cellIdentifier {
    static let  stepperCollectionCellIdentifier  = "StepperCollectionViewCell"
    static let  soundPresetsCollectionCelldentifier  = "SoundPresetsCollectionViewCell"
}

class SoundSettingViewController: UIViewController{
    
    @IBOutlet weak var presetCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    lazy var soundSettingViewModel = SoundSettingViewModel()
    //  @IBOutlet var buttons: [UIButton]!
    
    // MARK: -  labelValues of Equilizer Graph
    let labelValues = [32,64,128,256,512,1024,2048,4096]
    
    let slider = VSSlider()
    // MARK: -  Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewOutlet.delegate = self
        setUpOfCollectionViewCell()
        
    }
    
}

extension SoundSettingViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
//MARK: Custom methods
extension SoundSettingViewController {
    
    func setUpOfCollectionViewCell(){
        // Register the custom cell class
        let nib = UINib(nibName: cellIdentifier.stepperCollectionCellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier.stepperCollectionCellIdentifier)
        // Set the data source and delegate (you need to implement UICollectionViewDataSource methods)
        collectionView.dataSource = self
        collectionView.delegate = self
        //
        let presetButtonnib = UINib(nibName: cellIdentifier.soundPresetsCollectionCelldentifier, bundle: nil)
        presetCollectionView.register(presetButtonnib, forCellWithReuseIdentifier: cellIdentifier.soundPresetsCollectionCelldentifier)
        presetCollectionView.dataSource = self
        presetCollectionView.delegate = self
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.presetCollectionView.reloadData()
        }
    }
}

//MARK: -  Collection view delegate datasource
extension SoundSettingViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // Implement UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in your collection view
        if collectionView == presetCollectionView {
            return soundSettingViewModel.soundpresetlist.count
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue and configure your custom cell
        
        if collectionView == presetCollectionView {
            let cell = presetCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.soundPresetsCollectionCelldentifier, for: indexPath) as! SoundPresetsCollectionViewCell
            let presetsList = soundSettingViewModel.soundpresetlist[safe : indexPath.item]
            cell.presetButton.setTitle(presetsList?.name, for: .normal)
            if (presetsList?.isSelected ?? false) {
                cell.setSelectedButton()
            }else{
                cell.setUnSelectedButton()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.stepperCollectionCellIdentifier, for: indexPath) as! StepperCollectionViewCell
            cell.row = indexPath.item
            cell.setData()
            cell.delegate = self
            cell.setDataValue(value: labelValues[indexPath.item])
            
            return cell
        }
    }
    // Implement UICollectionViewDelegateFlowLayout method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size of each item (you can customize this per item if needed)
        if collectionView == presetCollectionView {
            return CGSize(width: collectionView.frame.width / 3, height: 38)
        } else {
            return CGSize(width: 43, height: 240)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == presetCollectionView {
            if let indexToChange = soundSettingViewModel.soundpresetlist.firstIndex(where: {$0.isSelected == true}) {
                soundSettingViewModel.soundpresetlist[safe: indexToChange]?.isSelected = false
            }
            soundSettingViewModel.soundpresetlist[safe: indexPath.item]?.isSelected = true
            DispatchQueue.main.async {
                self.presetCollectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SoundSettingViewController: StepperCollectionViewCellDelegate {
    func sliderValueChanged(newValue: Float, cellValue: Int) {
        print("Value on VC \(newValue)")
        print("Changes in \(labelValues[cellValue])")
    }
}

