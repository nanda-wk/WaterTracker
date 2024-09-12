//
//  AppTheme.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

enum AppTheme: String {
    case light
    case dark
    case system

    var colorScheme: ColorScheme? {
        switch self {
            case .light:
                return .light
            case .dark:
                return .dark
            case .system:
                return nil
        }
    }
}
