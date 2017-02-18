//
//  DataManager.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let shared: DataManager = DataManager()
    
    
    
    func saveDeckOfCards(completionHandler: (([Card]?) -> Void)?) {
        if let realm = try? Realm() {
            var deckOfCards = [Card]()
            for index in (0..<10) {
                let card = Card()
                card.question = "\(index)"
                card.identifier = index
                try? realm.write {
                    realm.add(card, update: true)
                    deckOfCards.append(card)
                }
            }
            arc4random_uniform(4)
            if completionHandler != nil {
                completionHandler!(deckOfCards)
            }
        }
    }
    //        apiManager.fetchAvailableDeckOfCards { (cards) in
    //            if let realm = try? Realm() {
    //                try? realm.write {
    //                    for interest in interests {
    //                        realm.add(interest, update: true)
    //                    }
    //                    if completionHandler != nil {
    //                        completionHandler!()
    //                    }
    //                }
    //            }
    //        }
}
