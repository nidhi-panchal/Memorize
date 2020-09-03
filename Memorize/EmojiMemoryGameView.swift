import SwiftUI

// This is the View
struct EmojiMemoryGameView: View {
    // Calls the ViewModel
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
            .padding(5)
            }
                .foregroundColor(Color.orange)
                .padding()
            Button(action: {
                withAnimation(.easeInOut(duration: 2)) {
                    self.viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
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
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // every var inside ZStack would require a self. before it, but calling it with self.body in ^^ does it for you so you don't have to type self everywhere
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                        .onAppear {
                            self.startBonusTimeAnimation()
                    }
                } else {
                    Pie(startAngle: Angle.degrees(0), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                }
                .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
