//
//  ContentView.swift
//  Memorize
//
//  Created by Nidhi Panchal on 7/5/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        // can take out content: from everything & close the parentheses & syntax still correct; i.e. HStack() {...}
        return HStack { // don't need to type return
            ForEach(viewModel.cards) { card in // <-- the actual iterator
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .foregroundColor(Color.orange)
            .padding()
            .font(Font.largeTitle)
        // foregroundColor on the ZStack changes every item into foreground of that color; can be overridden by calls to foregroundColor inside
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    // can't create variables inside of view builders
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
