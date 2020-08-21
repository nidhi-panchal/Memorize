//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Nidhi Panchal on 8/21/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    // Int? makes the return type optional; allows you to return nil
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
