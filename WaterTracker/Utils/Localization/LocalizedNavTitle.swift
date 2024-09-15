//
//  LocalizedNavTitle.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-15.
//

import SwiftUI

private struct LocalizedNavTitleModifier: ViewModifier {
    @EnvironmentObject private var preferences: UserPreferences

    var key: LocalizedKey
    var args: [String]
    var defaultValue: String

    init(_ key: LocalizedKey, args: [String] = [], default str: String? = nil) {
        self.key = key
        self.args = args
        self.defaultValue = str.orEmpty
    }

    func body(content: Content) -> some View {
        content
            .navigationTitle(key.localize(preferences.appLang, args: args).ifNilOrEmpty(defaultValue))
    }
}

extension View {
    func navigationTitle(_ key: LocalizedKey, args: [String] = [], default str: String? = nil) -> some View {
        self.modifier(LocalizedNavTitleModifier(key, args: args, default: str))
    }
}
