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
    
    dynamic var lifeProperty1Difference = 0
    dynamic var lifeProperty2Difference = 0
    dynamic var lifeProperty3Difference = 0
    dynamic var lifeProperty4Difference = 0
    
    dynamic var question = ""
    
    dynamic var imageURL = ""
    
    dynamic var identifier = 0
    
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
}
