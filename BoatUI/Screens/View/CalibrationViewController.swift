//
//  CalibrationViewController.swift
//  BoatUI
//
//  Created by NeoSOFT on 04/12/23.
//

import UIKit

enum calibrationImages: CaseIterable {

    case turnLeft
    case turnRight
    case tiltLeft
    case tiltRight
    case turnUp
    
    var description : String {
        switch self {
        case .turnLeft: return "TurnLeft"
        case .turnRight : return "TurnRight"
        case .tiltLeft: return "TiltLeft"
        case .tiltRight: return "TiltRight"
        case .turnUp: return "TurnUp"
        }
    }
}

class CalibrationViewController: UIViewController {
    
    @IBOutlet weak var calibrationCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let calibrationNameArray = ["TurnLeft","TurnRight","TiltLeft","TiltRight","TurnUp"]
    var isButtonClicked = true
    var currentIndex = 0
    var currentStack = 0 {
        didSet {
                calibrationCollectionView.isPagingEnabled = false
                calibrationCollectionView.scrollToItem(at: IndexPath(item: currentStack, section: 0), at: .right, animated: true)
            calibrationCollectionView.isPagingEnabled = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setUpOfCollectionViewCell()
    }
    
    func setUpOfCollectionViewCell(){
        
        let nib = UINib(nibName: "CalibrationCollectionViewCell", bundle: nil)
        calibrationCollectionView.register(nib, forCellWithReuseIdentifier: "CalibrationCollectionViewCell")
        
        calibrationCollectionView.dataSource = self
        calibrationCollectionView.delegate = self
        DispatchQueue.main.async {
            self.calibrationCollectionView.reloadData()
        }
      
        
    }
    
    @IBAction func nextButtonPressed(sender: UIButton){
        
        if currentStack < (calibrationImages.allCases.count - 1) {
            self.currentIndex += 1
        }
        else {
            self.currentStack = 0
            self.currentIndex = 0
        }
        if self.currentIndex % 2 != 0{
            nextButton.backgroundColor = .red
        }else {
            nextButton.backgroundColor = .gray
            self.currentStack = currentStack + 1
        }
   }
    @IBAction func backButtonAction(_ sender: UIButton) {
    }
}

extension CalibrationViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calibrationImages.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = calibrationCollectionView.dequeueReusableCell(withReuseIdentifier: "CalibrationCollectionViewCell", for: indexPath) as! CalibrationCollectionViewCell
        
        cell.calibrationImage.image = UIImage(named: calibrationImages.allCases[indexPath.item].description)
        cell.calibrationLabel.text = calibrationNameArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 275)
    }
    
}
