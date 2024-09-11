//
//  Item.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
