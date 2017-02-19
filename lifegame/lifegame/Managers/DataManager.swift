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
            if let cardsDic = (response.result.value as? [Dictionary<String,AnyObject>]) {
                for cardDict in cardsDic {
                    let rlmCard = RLMCard(infoDictionary: cardDict)
                    
                    if let realm = try? Realm() {
                        try? realm.write {
                            realm.add(rlmCard, update: true)
                        }
                    }
                }
            }
            completionHandler!(true)
        }
    }
    
    func loadDeck(completionHandler: (([RLMCard]) -> Void)?) {
        if let realm = try? Realm() {
            let cards = Array(realm.objects(RLMCard.self))
            if completionHandler != nil {
                completionHandler!(cards)
            }
        }
    }
    
    func clearDeck(completionHandler: ((Bool) -> Void)?) {
        if let realm = try? Realm() {
            realm.deleteAll()
            if completionHandler != nil {
                completionHandler!(true)
            }
        } else {
            if completionHandler != nil {
                completionHandler!(false)
            }
        }
    }
    
}
