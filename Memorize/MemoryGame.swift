//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nidhi Panchal on 8/12/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    // need mutating if the function changes anything i.e. &var in cpp
    mutating func choose(card: Card) {
        print("card chosen: \(card)") // this is how you embed an argument \()
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    // second name (card) is an internal name, of is an external name; can refer to argument by internal name within function
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)  // let means you don't change it
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
