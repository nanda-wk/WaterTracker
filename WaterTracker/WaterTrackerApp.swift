//
//  WaterTrackerApp.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI
import SwiftData

var langDict: [String: [String: String]] = [:]

@main
struct WaterTrackerApp: App {

    @StateObject private var preferences = UserPreferences()

    init() {
        langDict = Bundle.main.decode([String: [String: String]].self, from: "Language.json")
    }

    var body: some Scene {
        WindowGroup {
            OnboardingScreen()
                .preferredColorScheme(preferences.appTheme.colorScheme)
        }
        .environmentObject(preferences)
    }
}
