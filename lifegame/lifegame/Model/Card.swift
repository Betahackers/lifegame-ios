//
//  Card.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    
    dynamic var identifier = 0
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
    convenience init(infoDictionary user: [String:Any]) {
        self.init()
        
        if let identifier = user["id"] as? Int {
            self.identifier = identifier
        }
        
    }

    
}
