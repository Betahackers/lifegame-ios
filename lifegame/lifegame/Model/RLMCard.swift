//
//  RLMCard.swift
//  lifegame
//
//  Created by Marek on 19/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation
import RealmSwift

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
