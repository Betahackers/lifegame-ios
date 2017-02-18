//
//  ViewController.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Consumer {

    // MARK: - implementation of consumer protocol
    
    func update(lifePorperties: LifeProperty, value: Int) {
        
    }
    
    func update(cardList: [Card]) {
        
    }
    
}

protocol Consumer {
    func update(lifePorperties: LifeProperty, value: Int)
    func update(cardList: [Card])
}

enum LifeProperty {
    case money
    case family
    case health
}

class Card {
    
}

