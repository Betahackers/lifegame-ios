//
//  SplashViewController.swift
//  Activus
//
//  Created by Marek on 02/12/2016.
//  Copyright © 2016 Marek Pivovarnik. All rights reserved.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dataManager = DataManager.shared
    
    var shouldDismissSplash = [ false, false ] {
        didSet {
            if shouldDismissSplash.reduce(true, { $0 && $1 }) {
                showTutorial()
            }
        }
    }
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager.saveDeck { [weak self] (success) in
            print("done")
            self?.shouldDismissSplash[0] = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
            self?.shouldDismissSplash[1] = true
//            self?.spinner.startAnimating()
//            self?.spinner.isHidden = false
        }
    }

    // MARK: - Helper functions
    
    private func showTutorial() {
        let lifegameStoryboard = UIStoryboard(name: "Lifegame", bundle: nil)
        let lifegameViewController = lifegameStoryboard.instantiateViewController(withIdentifier: "LifegameViewController") as! LifegameViewController
        
        lifegameViewController.makeRootViewControllerWithTransitionDuration(0.3)
    }
}
