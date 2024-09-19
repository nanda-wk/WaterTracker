//
//  ChooseLanguageScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-19.
//

import SwiftUI

struct ChooseLanguageScreen: View {
    @EnvironmentObject private var preferences: UserPreferences

    var body: some View {
        List {
            ForEach(AppLanguage.allCases, id: \.rawValue, content: LangOptionView(lang:))
        }
        .navigationTitle(.choose_a_language)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func LangOptionView(lang: AppLanguage) -> some View {
        HStack {
            HStack(spacing: 12) {
                Image(lang.image).resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(lang.title).font(.headline)
                    Text(lang.desc).font(.headline).foregroundColor(.secondary)
                }
                .padding(.vertical, 12)
            }

            Spacer()

            if preferences.appLang == lang {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.appSecondary)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            preferences.appLang = lang
        }
    }
}

#Preview {
    ChooseLanguageScreen()
        .environmentObject(UserPreferences())
}
