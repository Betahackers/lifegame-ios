//
//  Realm+CompletionHandlerAfterWriteTransaction.swift
//  lifegame
//
//  Created by Marek on 19/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import Foundation

import RealmSwift

extension Realm {
    
    /** Performs actions contained within the given block inside a write transaction with
     completion block.
     
     - parameter block: write transaction block
     - completion: completion executed after transaction block
     */
    func write(transactionBlock block: (Void) -> (), completion: (Void) -> ()) throws {
        do {
            try write(block)
            completion()
        } catch {
            throw error
        }
    }
}
