//
//  OnboardingScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct OnboardingScreen: View {
    @EnvironmentObject private var preferences: UserPreferences

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                VStack(spacing: 40) {
                    HStack {
                        ForEach(Onboarding.onbordingCards, id: \.self) { card in
                            OnboardingCard(card)
                        }
                    }
                    .scrollTargetLayout()

                    PagingIndicator()
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .padding(.top, 70)

            Spacer()

            AppButton(title: .btn_get_started) {
                
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 28)
        }
    }

    @ViewBuilder
    func OnboardingCard(_ card: Onboarding) -> some View {
        VStack(spacing: 25) {
            Image(card.image)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)

            LocalizedText(card.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(.textBlack))
                .lineLimit(2, reservesSpace: true)
                .multilineTextAlignment(.center)

            LocalizedText(card.description)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(Color(.textGray))
                .lineLimit(3, reservesSpace: true)
                .multilineTextAlignment(.center)
        }
        .containerRelativeFrame(.horizontal)
    }
}

#Preview {
    OnboardingScreen()
        .environmentObject(UserPreferences())
}
