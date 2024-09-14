//
//  Optional.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .none: return ""
        case .some(let v): return v
        }
    }

    var nilIfEmpty: String? {
        self.flatMap { $0.isEmpty ? nil : $0 }
    }

    func ifNilOrEmpty(_ value: String) -> String {
        self.orEmpty.isEmpty ? value : self.orEmpty
    }
}
