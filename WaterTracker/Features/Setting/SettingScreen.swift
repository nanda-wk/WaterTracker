//
//  SettingScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-19.
//

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var isPresented: Bool = false

    var body: some View {
        List {
            Section {
                Button {
                    isPresented.toggle()
                } label: {
                  HStack {
                    LocalizedText(.app_language)
                          .font(.headline)
                    Spacer()
                    Text(preferences.appLang.title)
                          .font(.headline)
                          .foregroundStyle(.appPrimary)
                    Image(systemName: "chevron.right")
                      .foregroundStyle(Color(uiColor: .systemGray2))
                  }
                }
                .tint(.primary)
            }

        }
        .navigationTitle(.settings)
        .sheet(isPresented: $isPresented) {
            ChooseLanguageScreen()
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    NavigationStack {
        SettingScreen()
            .environmentObject(UserPreferences())
    }
}
