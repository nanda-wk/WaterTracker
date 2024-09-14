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
        Onboarding(image: .onboarding1, title: .onboarding_1_title, description: .onboarding_1_desc),
        Onboarding(image: .onboarding2, title: .onboarding_2_title, description: .onboarding_2_desc),
        Onboarding(image: .onboarding3, title: .onboarding_3_title, description: .onboarding_3_desc)
    ]
}
