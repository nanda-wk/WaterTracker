//
//  LocalizedKey.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import Foundation

enum LocalizedKey: String {
    case launchDesc
    case onboarding1Title
    case onboarding1Desc
    case onboarding2Title
    case onboarding2Desc
    case onboarding3Title
    case onboarding3Desc
    case btnGetStarted
    case home
    case analysis
    case goal
    case settings
    case profile

    func localize(_ lang: AppLanguage) -> String? {
        let dict = langDict[self.rawValue]
        switch lang {
            case .Eng:
                return dict?[lang.rawValue]
            case .Mm:
                return dict?[lang.rawValue]
        }
    }
}
