//
//  RLMAnswer.swift
//  lifegame
//
//  Created by Marek on 19/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation
import RealmSwift

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
