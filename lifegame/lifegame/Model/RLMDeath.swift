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
    
    var reason = CauseOfDeath.tooOld
    dynamic var effect = ""
    dynamic var cause = ""
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
        
        if let effect = card["effect"] as? String {
            self.effect = effect
        }
        
        if let cause = card["cause"] as? String {
            self.cause = cause
        }
        
        if let reasonServer = card["causeOfDeath"] as? String {
            if reasonServer == "age_max" {
                self.reason = CauseOfDeath.tooOld
            } else if reasonServer == "money_max" {
                self.reason = CauseOfDeath.tooMuchMoney
            } else if reasonServer == "money_min" {
                self.reason = CauseOfDeath.tooLessMoney
            } else if reasonServer == "fun_max" {
                self.reason = CauseOfDeath.tooMuchFun
            } else if reasonServer == "fun_min" {
                self.reason = CauseOfDeath.tooLessFun
            } else if reasonServer == "love_max" {
                self.reason = CauseOfDeath.tooMuchLove
            } else if reasonServer == "love_min" {
                self.reason = CauseOfDeath.tooLessLove
            } else if reasonServer == "health_min" {
                self.reason = CauseOfDeath.tooMuchHealth
            } else if reasonServer == "health_max" {
                self.reason = CauseOfDeath.tooLessHealth
            }
        }
    }
}
