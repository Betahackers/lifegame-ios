//
//  RLMCard.swift
//  lifegame
//
//  Created by Marek on 19/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation
import RealmSwift

class RLMDeath: Object {
    
    var causeOfDeath = CauseOfDeath.tooOld
    var reason = ""
    var effect = ""
    dynamic var identifier = 0
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
    // MARK: - Initialisation
    
    convenience init(infoDictionary card: [String:Any]) {
        self.init()
        
        if let identifier = card["identifier"] as? Int {
            self.identifier = identifier
        }
        
        if let causeOfDeath = card["causeOfDeath"] as? String {
            if causeOfDeath == "tooOld" {
                self.causeOfDeath = CauseOfDeath.tooOld
            }
        }
    }
}
