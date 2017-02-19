//
//  GameOverViewController.swift
//  lifegame
//
//  Created by Marek on 19/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var causeImageView: UIImageView!
    @IBOutlet weak var causeText: UILabel!
    @IBOutlet weak var ageText: UILabel!
    @IBOutlet weak var playAagainButton: UIButton!
    
    private let dataManager = DataManager.shared
    
    var causeOfDeath: CauseOfDeath = .tooLessFun
    var age = 15
    
    // MARK: - Outlets
    
    // MARK: - Actions
    override func viewDidLoad() {
        
        self.ageText.text = "\(age)"
        
        var isHeaven = false
    
        switch causeOfDeath {
        case .tooOld:
            self.causeImageView.image = UIImage (named: "love")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You're too old man"
            isHeaven = true
        case .tooLessMoney:
            self.causeImageView.image = UIImage (named: "money")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You ran out of money"
            isHeaven = false
        case .tooLessLove:
            self.causeImageView.image = UIImage (named: "love")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You ran out of love"
            isHeaven = false
        case .tooLessFun:
            self.causeImageView.image = UIImage (named: "fun")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You ran out of fun"
            isHeaven = false
        case .tooLessHealth:
            self.causeImageView.image = UIImage (named: "health")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You ran out of health"
            isHeaven = false
        case .tooMuchFun:
            self.causeImageView.image = UIImage (named: "fun")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You had way too much fun"
            isHeaven = true
        case .tooMuchLove:
            self.causeImageView.image = UIImage (named: "love")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You had way too much love"
            isHeaven = true
        case .tooMuchHealth:
            self.causeImageView.image = UIImage (named: "health")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You had way too much health"
            isHeaven = true
        case .tooMuchMoney:
            self.causeImageView.image = UIImage (named: "money")!.withRenderingMode(.alwaysTemplate)
            self.causeText.text = "You had way too much money"
            isHeaven = true
        }
        
        if isHeaven {
            self.backgroundImageView.image = UIImage (named: "heaven")
            self.causeImageView.tintColor = UIColor.init(colorLiteralRed: 255/255, green: 72/255, blue: 93/255, alpha: 1)
            self.causeText.textColor = UIColor.init(colorLiteralRed: 31/255, green: 59/255, blue: 81/255, alpha: 1)
            self.playAagainButton .setTitleColor(UIColor.init(colorLiteralRed: 31/255, green: 59/255, blue: 81/255, alpha: 1), for: .normal)
        } else {
            self.backgroundImageView.image = UIImage (named: "hell")
            self.causeImageView.tintColor = UIColor.white
            self.causeText.textColor = UIColor.white
            self.playAagainButton .setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    
    @IBAction func restartGameActionButton(_ sender: Any) {
        
        dataManager.clearDeck { [weak self] (isCleared) in
            if isCleared {
                self?.dataManager.saveDeck(completionHandler: { (newDeckIsLoaded) in
                    if newDeckIsLoaded {
                        let lifegameStoryboard = UIStoryboard(name: "Lifegame", bundle: nil)
                        let lifegameViewController = lifegameStoryboard.instantiateViewController(withIdentifier: "LifegameViewController") as! LifegameViewController
                        
                        lifegameViewController.makeRootViewControllerWithTransitionDuration(0.3)
                    }
                })
            }
        }
        
        
    }
    
}
