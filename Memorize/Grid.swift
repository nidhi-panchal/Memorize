//
//  Grid.swift
//  Memorize
//
//  Created by Nidhi Panchal on 8/20/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
          }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        // same function defined in MemoryGame.swift so it's like this so we can define it once in its own file
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            // ! unwraps the optional (index is an Int?)
            .position(layout.location(ofItemAt: index))
        
// THIS IS MORE CORRECT BUT realistically the app should never crash so you don't really need to do it
/*
        // Group is like a ZStack
        // if index == nil, it will return some empty content
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    // ! unwraps the optional (index is an Int?)
                    .position(layout.location(ofItemAt: index!))
            }
        }
 */


    }
    

}

