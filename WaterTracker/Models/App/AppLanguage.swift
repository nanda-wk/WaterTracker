//
//  AppLanguage.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

enum AppLanguage: String {

    case Eng
    case Mm

    var title: String {
        switch self {
        case .Eng:
            return "English"
        case .Mm:
            return "Myanmar"
        }
    }

    var desc: String {
        switch self {
        case .Eng:
            return "(English)"
        case .Mm:
            return "(မြန်မာ)"
        }
    }

    var image: ImageResource {
        switch self {
        case .Eng:
            return .eng
        case .Mm:
            return .mm
        }
    }
}
