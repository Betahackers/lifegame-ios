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

class RLMAnswer: Object {
    
    dynamic var identifier = 0
    dynamic var text = ""
    dynamic var direction = ""
    dynamic var love = 0
    dynamic var money = 0
    dynamic var fun = 0
    dynamic var health = 0
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
    // MARK: - Initialisation
    
    convenience init(infoDictionary card: [String:Any]) {
        self.init()
        
        if let identifier = card["id"] as? Int {
            self.identifier = identifier
        }
        
        if let text = card["text"] as? String {
            self.text = text
        }
        
        if let direction = card["direction"] as? String {
            self.direction = direction
        }
        
        if let points = card["points"] as? [Dictionary<String,AnyObject>] {
            for point in points {
                let slug = point["slug"]
                let score = point["value"] as! Int
                if (slug?.isEqual(to: "love"))! {
                    self.love = score
                } else if (slug?.isEqual(to: "money"))! {
                    self.money = score
                } else if (slug?.isEqual(to: "fun"))! {
                    self.fun = score
                } else if (slug?.isEqual(to: "health"))! {
                    self.health = score
                }
            }
        }
    }
}


class RLMCard: Object {
    
    dynamic var identifier = 0
    dynamic var question = ""
    dynamic var imageURL = ""
    dynamic var person = ""
    dynamic var title = ""
    var answers = List<RLMAnswer>()
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
    // MARK: - Initialisation
    
    convenience init(infoDictionary card: [String:Any]) {
        self.init()
        
        if let identifier = card["id"] as? Int {
            self.identifier = identifier
        }
        
        if let imageURL = card["image_url"] as? String {
            self.imageURL = imageURL
        }
        
        if let person = card["person"] as? String {
            self.person = person
        }
        
        if let title = card["title"] as? String {
            self.title = title
        }
        
        if let answers = card["answers"] as? [Dictionary<String,AnyObject>] {
            for answer in answers {
                let rlmAnswer = RLMAnswer(infoDictionary: answer)
                self.answers.append(rlmAnswer)
            }
        }
    }
}

class DataManager {
    
    static let shared: DataManager = DataManager()
    
    func loadDeck(completionHandler: ((Bool) -> Void)?) {
        
        Alamofire.request("https://lifegame-api.herokuapp.com/cards").responseJSON { (response) in
            
            print(response)
            
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

        
            print("done")
            
            completionHandler!(true)
        }
    }
    
//    func saveDeckOfCards(completionHandler: ((Bool) -> Void)?) {
//        if let realm = try? Realm() {
//            for index in (0..<10) {
//                let card = Card()
//                card.question = "\(index)"
//                card.identifier = index
//                try? realm.write {
//                    realm.add(card, update: true)
//                }
//            }
//            if completionHandler != nil {
//                completionHandler!(true)
//            }
//        }
//    }
    
    
}
