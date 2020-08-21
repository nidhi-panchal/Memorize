//
//  Array+Only.swift
//  Memorize
//
//  Created by Nidhi Panchal on 8/21/20.
//  Copyright © 2020 Nidhi Panchal. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
