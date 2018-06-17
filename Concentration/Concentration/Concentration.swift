//
//  Concentration.swift
//  Concentration
//
//  Created by XMZ on 06/10/2018.
//  Copyright © 2018 Jogchat. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOnlyOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func isMatched(at index: Int) -> Bool {
        return cards[index].isMatched
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if let matchIndex = indexOfOnlyOneFaceUpCard, matchIndex != index {
            if cards[matchIndex] == cards[index] {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
        } else {
            indexOfOnlyOneFaceUpCard = index
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair")
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
