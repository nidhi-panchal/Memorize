import SwiftUI

// This is the View
struct EmojiMemoryGameView: View {
    // Calls the ViewModel
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        // Navigation View for Assignment 1 Task 6
        NavigationView {
            HStack {
                ForEach(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                }
                .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundColor(Color.orange)
            .padding()
            .font(viewModel.cards.count < 5 ? Font.largeTitle : Font.title)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}
