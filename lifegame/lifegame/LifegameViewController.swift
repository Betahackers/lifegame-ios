//
//  ViewController.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var prop1 = 0
    var prop2 = 0
    var prop3 = 0
    var prop4 = 0
    
    var deckOfCards = [Card]()
    
    func fetchCards(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    func loadDeck() {
        for (index, card) in deckOfCards.enumerated() {
            let views = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
            if let view = views?.first as? CardView {
                view.cardImageView.image = UIImage() // CardImage
                view.questionLabel.text = "\(index)"
            }
        }
    }
    
}

