//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nidhi Panchal on 8/12/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // private(set) var model: MemoryGame<String>  // set means that everything else can still see the model, not 100% private
    // publishes anytime it changes
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🤠", "👻", "🤪"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
