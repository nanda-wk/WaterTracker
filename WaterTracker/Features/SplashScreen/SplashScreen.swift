//
//  SplashScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject private var preferences: UserPreferences

    var body: some View {
        ZStack {
            Color.accent
                .ignoresSafeArea()

            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)

                Text("Drops of Water Tracker")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                LocalizedText(.launchDesc)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

            }
        }
    }
}

#Preview {
    SplashScreen()
        .environmentObject(UserPreferences())
}
