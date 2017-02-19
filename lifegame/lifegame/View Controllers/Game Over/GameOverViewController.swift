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
    @IBOutlet weak var playAagainButton: UIButton!
    
    private let dataManager = DataManager.shared
    
    var causeOfDeath: CauseOfDeath = .tooLessFun
    
    // MARK: - Outlets
    
    @IBOutlet weak var restartGameButton: UIButton!
    
    // MARK: - Actions
    override func viewDidLoad() {
        
        var isHeaven = false
    
        switch causeOfDeath {
        case .tooOld:
            self.causeImageView.image = UIImage (named: "love")
            self.causeText.text = "You're too old man"
            isHeaven = true
        case .tooLessMoney:
            self.causeImageView.image = UIImage (named: "money")
            self.causeText.text = "You ran out of money"
            isHeaven = false
        case .tooLessLove:
            self.causeImageView.image = UIImage (named: "love")
            self.causeText.text = "You ran out of love"
            isHeaven = false
        case .tooLessFun:
            self.causeImageView.image = UIImage (named: "fun")
            self.causeText.text = "You ran out of fun"
            isHeaven = false
        case .tooLessHealth:
            self.causeImageView.image = UIImage (named: "health")
            self.causeText.text = "You ran out of health"
            isHeaven = false
        case .tooMuchFun:
            self.causeImageView.image = UIImage (named: "fun")
            self.causeText.text = "You had way too much fun"
            isHeaven = true
        case .tooMuchLove:
            self.causeImageView.image = UIImage (named: "love")
            self.causeText.text = "You had way too much love"
            isHeaven = true
        case .tooMuchHealth:
            self.causeImageView.image = UIImage (named: "health")
            self.causeText.text = "You had way too much health"
            isHeaven = true
        case .tooMuchMoney:
            self.causeImageView.image = UIImage (named: "money")
            self.causeText.text = "You had way too much money"
            isHeaven = true
        }
        
        if isHeaven {
            self.backgroundImageView.image = UIImage (named: "heaven")
            self.backgroundImageView.tintColor = UIColor.red
            self.causeText.textColor = UIColor.gray
            self.playAagainButton.titleLabel?.textColor = UIColor.gray
        } else {
            self.backgroundImageView.image = UIImage (named: "hell")
            self.causeText.textColor = UIColor.white
            self.playAagainButton.titleLabel?.textColor = UIColor.white
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
