//
//  LocalizedButton.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-19.
//

import SwiftUI

struct LocalizedButton: View {
    @EnvironmentObject private var preferences: UserPreferences

    var key: LocalizedKey
    var args: [String]
    var defaultValue: String
    var action: () -> ()

    init(_ key: LocalizedKey, args: [String] = [], default str: String? = nil, action: @escaping () -> ()) {
        self.key = key
        self.args = args
        self.defaultValue = str.orEmpty
        self.action = action
    }

    var body: some View {
        Button(key.localize(preferences.appLang, args: args).ifNilOrEmpty(defaultValue), action: action)
    }
}

