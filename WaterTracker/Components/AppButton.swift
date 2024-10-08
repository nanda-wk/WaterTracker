//
//  AppButton.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct AppButton: View {
    var title: LocalizedKey
    var height: CGFloat = 60
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.appPrimary)
                    .frame(height: height)

                LocalizedText(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.textWhite)
            }
        }
    }
}

struct BackButton: View {
    var action: () -> Void
    var body: some View {
        Button (action: action) {
            Image(systemName: "arrow.backward")
                .foregroundStyle(.appPrimary)
        }
    }
}

#Preview {
    AppButton(title: .btn_get_started) {}
        .environmentObject(UserPreferences())
}
