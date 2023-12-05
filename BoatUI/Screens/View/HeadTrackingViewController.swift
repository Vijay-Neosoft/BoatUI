//
//  3DHeadTrackingViewController.swift
//  BoatUI
//
//  Created by NeoSOFT on 05/12/23.
//

import UIKit

class HeadTrackingViewController: UIViewController {
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configButton()
        navigationSetup()
    }
    
    func navigationSetup(){
        self.title = "3DHeadtracking"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    func configButton(){
        playButtonOutlet.layer.cornerRadius = playButtonOutlet.frame.width / 2
        playButtonOutlet.layer.masksToBounds = true
    }
}
