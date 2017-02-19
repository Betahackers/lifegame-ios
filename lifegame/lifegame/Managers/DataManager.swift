//
//  DataManager.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class DataManager {
    
    static let shared: DataManager = DataManager()
    
    func saveDeck(completionHandler: ((Bool) -> Void)?) {
        Alamofire.request("https://lifegame-api.herokuapp.com/cards").responseJSON { (response) in
            if let realm = try? Realm() {
                try? realm.write(
                    transactionBlock: { _ in
                        if let cardsDic = (response.result.value as? [Dictionary<String,AnyObject>]) {
                            for (index, cardDict) in cardsDic.enumerated() {
                                let rlmCard = RLMCard(infoDictionary: cardDict)
                                rlmCard.identifier = index
                                realm.add(rlmCard, update: true)
                            }
                        }
                },
                    completion: { _ in
                        if completionHandler != nil {
                            completionHandler!(true)
                        }
                })
            }
            
        }
    }
    
    func saveEndings(completionHandler: ((Bool) -> Void)?) {
        Alamofire.request("https://lifegame-api.herokuapp.com/endings").responseJSON { (response) in
            if let realm = try? Realm() {
                try? realm.write(
                    transactionBlock: { _ in
                        if let endingArray = (response.result.value as? [Dictionary<String,AnyObject>]) {
                            for (index, endingDict) in endingArray.enumerated() {
                                let rlmEnding = RLMDeath(infoDictionary: endingDict)
                                rlmEnding.identifier = index
                                realm.add(rlmEnding, update: true)
                            }
                        }
                },
                    completion: { _ in
                        if completionHandler != nil {
                            completionHandler!(true)
                        }
                })
            }
            
        }
    }
    
    func loadDeck(completionHandler: (([RLMCard]) -> Void)?) {
        if let realm = try? Realm() {
            let cards = Array(realm.objects(RLMCard.self).sorted(byKeyPath: "identifier", ascending: false))
            if completionHandler != nil {
                completionHandler!(cards)
            }
        }
    }
    
    func clearDeck(completionHandler: ((Bool) -> Void)?) {
        if let realm = try? Realm() {
            try? realm.write(
                transactionBlock: { _ in
                    realm.deleteAll()
            }, completion: { _ in
                if completionHandler != nil {
                    completionHandler!(true)
                }
            })
        } else {
            if completionHandler != nil {
                completionHandler!(false)
            }
        }
    }
    
}
