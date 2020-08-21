//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nidhi Panchal on 8/12/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import Foundation

// equatable means that == is implemented for the type
struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    // [Int]() declares an array of ints
    // optionals are automatically initialized to nil
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                // set false unless index == newValue
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // need mutating if the function changes anything i.e. &var in cpp
    mutating func choose(card: Card) {
        print("card chosen: \(card)") // this is how you embed an argument \()
        // happens only if non nil
        // , is like a sequential and; this won't work with &&
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
        }
    }
    
/* BECAUSE IT'S DEFINED IN GRID
    // second name (card) is an internal name, of is an external name; can refer to argument by internal name within function
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
 */
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)  // let means you don't change it
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
