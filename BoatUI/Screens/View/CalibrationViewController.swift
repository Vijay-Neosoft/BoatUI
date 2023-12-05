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
fileprivate struct cellIdentifier {
    
    static let  CalibrationCollectionViewCellldentifier  = "CalibrationCollectionViewCell"
}

class CalibrationViewController: UIViewController {
    
    @IBOutlet weak var calibrationCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let calibrationNameArray = ["Turn Left","Turn Right","Tilt Left","Tilt Right","Turn Up"]
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
        navigationBarSetup()
        
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets.bottom = 0
        }
    }
    
    func navigationBarSetup(){
        self.title = "Calibration"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setUpOfCollectionViewCell(){
        
        let nib = UINib(nibName: cellIdentifier.CalibrationCollectionViewCellldentifier, bundle: nil)
        calibrationCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier.CalibrationCollectionViewCellldentifier)
        calibrationCollectionView.dataSource = self
        calibrationCollectionView.delegate = self
        DispatchQueue.main.async {
            self.calibrationCollectionView.reloadData()
        }
    }
    
    @IBAction func nextButtonPressed(sender: UIButton){
        
        if currentStack < (calibrationImages.allCases.count - 1) {
            self.currentIndex += 1
        } else {
            let headVC = storyboard?.instantiateViewController(withIdentifier: "headTrackingViewController") as! HeadTrackingViewController
            navigationController?.pushViewController(headVC, animated: true)
        }
        if self.currentIndex % 2 != 0{
            nextButton.backgroundColor = .red
            nextButton.tintColor = .white
        }else {
            nextButton.backgroundColor = .gray
            nextButton.tintColor = .black
            if currentStack < (calibrationImages.allCases.count - 1) {
                self.currentStack = currentStack + 1
            }
        }
    }
    
}

extension CalibrationViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calibrationImages.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = calibrationCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.CalibrationCollectionViewCellldentifier, for: indexPath) as! CalibrationCollectionViewCell
        
        cell.calibrationImage.image = UIImage(named: calibrationImages.allCases[indexPath.item].description)
        cell.calibrationLabel.text = calibrationNameArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 275)
    }
    
}
