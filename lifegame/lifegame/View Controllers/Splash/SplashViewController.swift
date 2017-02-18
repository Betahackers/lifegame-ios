//
//  SplashViewController.swift
//  Activus
//
//  Created by Marek on 02/12/2016.
//  Copyright © 2016 Marek Pivovarnik. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
                self?.showTutorial()
        }
    }

    private func showTutorial() {
        let vc = LifeGameViewController() //change this to your class name
        self.present(vc, animated: true, completion: nil)
    }
}
