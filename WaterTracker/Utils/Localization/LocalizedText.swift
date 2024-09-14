//
//  LocalizedText.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct LocalizedText: View {
    @EnvironmentObject private var preferences: UserPreferences

    var key: LocalizedKey
    var args: [String]
    var defaultValue: String

    init(_ key: LocalizedKey, args: [String] = [], default defaultValue: String? = nil) {
        self.key = key
        self.args = args
        self.defaultValue = defaultValue.orEmpty
    }

    var body: some View {
        Text(key.localize(preferences.appLang, args: args).ifNilOrEmpty(defaultValue))
    }
}
