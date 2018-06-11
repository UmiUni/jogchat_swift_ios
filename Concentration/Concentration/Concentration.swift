//
//  Concentration.swift
//  Concentration
//
//  Created by XMZ on 06/10/2018.
//  Copyright © 2018 Jogchat. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOnlyOneFaceUpCard: Int?
    
    func isMatched(at index: Int) -> Bool {
        return cards[index].isMatched
    }
    
    func chooseCard(at index: Int) {
        if let matchIndex = indexOfOnlyOneFaceUpCard, matchIndex != index {
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfOnlyOneFaceUpCard = nil
        } else {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOnlyOneFaceUpCard = index
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        var temp = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            temp += [card, card]
        }
        
        for _ in 0..<temp.count {
            let rand = Int(arc4random_uniform(UInt32(temp.count)))
            
            cards.append(temp[rand])
            
            temp.remove(at: rand)
        }
    }
}
