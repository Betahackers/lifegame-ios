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
    
    private let dataManager = DataManager.shared
    
    var causeOfDeath: CauseOfDeath?
    
    // MARK: - Outlets
    
    @IBOutlet weak var restartGameButton: UIButton!
    
    // MARK: - Actions
    
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
