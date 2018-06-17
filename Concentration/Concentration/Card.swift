//
//  Card.swift
//  Concentration
//
//  Created by XMZ on 06/10/2018.
//  Copyright © 2018 Jogchat. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {
        return id
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    var isFaceUp = false
    var isMatched = false
    private var id: Int
    
    private static var idFactory = 0
    
    private static func getUniqId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        self.id = Card.getUniqId()
    }
}
