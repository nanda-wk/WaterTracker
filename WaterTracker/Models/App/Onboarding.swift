//
//  Onboarding.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct Onboarding: Hashable {
    let image: ImageResource
    let title: LocalizedKey
    let description: LocalizedKey

    static let onbordingCards = [
        Onboarding(image: .onboarding1, title: .onboarding1Title, description: .onboarding1Desc),
        Onboarding(image: .onboarding2, title: .onboarding2Title, description: .onboarding2Desc),
        Onboarding(image: .onboarding3, title: .onboarding3Title, description: .onboarding3Desc)
    ]
}
