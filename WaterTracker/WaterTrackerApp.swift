//
//  WaterTrackerApp.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftData
import SwiftUI

var langDict: [String: [String: String]] = [:]

@main
struct WaterTrackerApp: App {
    @StateObject private var preferences = UserPreferences()
    @State var isLoading = true

    init() {
        langDict = Bundle.main.decode([String: [String: String]].self, from: "Language.json")
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if !isLoading {
                    if !preferences.isFirstLaunch {
                        NavigationView {
                            TabScreen()
                        }
                    } else {
                        OnboardingScreen()
                    }
                } else {
                    SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isLoading = false
                            }
                        }
                }
            }
            .preferredColorScheme(preferences.appTheme.colorScheme)
        }
        .environmentObject(preferences)
    }
}
