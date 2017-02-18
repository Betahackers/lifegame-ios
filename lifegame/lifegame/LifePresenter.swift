//
//  LifePresenter.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation

class LifePresenter: Producer {
    
    func requestCards() {
        
    }
    
    func processAnswer(fromCard: Card, asnwer: Bool) {
        
    }
    
}

protocol Producer {
    func requestCards()
    func processAnswer(fromCard: Card, asnwer: Bool)
}
