//
//  UserPreferences.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

@MainActor
class UserPreferences: ObservableObject {
    @AppStorage("appLang") var appLang: AppLanguage = .Eng
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
}
