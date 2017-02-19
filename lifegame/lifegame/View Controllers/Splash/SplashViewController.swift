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
    
    // MARK: - Outlets
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    @IBOutlet weak var splashImageView: UIImageView!
    
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
        
        spinner.isHidden = true
        
        self.splashImageView.alpha = 0;
        
        dataManager.saveDeck { [weak self] (success) in
            
            self?.dataManager.saveEndings(completionHandler: { (success) in
//                let ending = self?.dataManager.loadEnding(forCauseOfDeatch: .tooLessFun)
                self?.shouldDismissSplash[0] = true
            })
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            
            var imgListArray = [UIImage]()
            for countValue in 0...50
            {
                let strImageName : String = "splash_\(countValue).png"
                let image  = UIImage(named:strImageName)
                imgListArray.append(image!)
            }
            
            self?.splashImageView.animationImages = imgListArray;
            self?.splashImageView.animationDuration = 3.0
            self?.splashImageView.animationRepeatCount = 1
            self?.splashImageView.startAnimating()
            self?.splashImageView.alpha = 1;
        }
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { [weak self] _ in
            self?.shouldDismissSplash[1] = true
            self?.spinner.startAnimating()
            self?.spinner.isHidden = false
        }
    }

    // MARK: - Helper functions
    
    private func showTutorial() {
        let lifegameStoryboard = UIStoryboard(name: "Lifegame", bundle: nil)
        let lifegameViewController = lifegameStoryboard.instantiateViewController(withIdentifier: "LifegameViewController") as! LifegameViewController
        
        lifegameViewController.makeRootViewControllerWithTransitionDuration(0.3)
    }
}
