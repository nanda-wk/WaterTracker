//
//  LocalizedKey.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import Foundation

enum LocalizedKey: String {
    case launch_desc
    case onboarding_1_title
    case onboarding_1_desc
    case onboarding_2_title
    case onboarding_2_desc
    case onboarding_3_title
    case onboarding_3_desc
    case btn_get_started
    case home
    case analysis
    case goal
    case settings
    case profile
    case greeting
    case x_ml_x_glass
    case btn_add_goal
    case target
    case btn_go_to_dashboard
    case x_goal_motivation
    case title_anaylsis
    case water
    case x_liter
    case walk
    case steps_completed
    case calories
    case kcol
    case hours
    case sleep
    case heart
    case title_set_your_goal
    case water_goal
    case water_goal_desc
    case title_profile
    case first_name
    case last_name
    case email
    case age
    case error_textfield_blank
    case choose_a_language
    case app_language

    func localize(_ lang: AppLanguage) -> String? {
        let dict = langDict[rawValue]
        switch lang {
        case .Eng:
            return dict?[lang.rawValue]
        case .Mm:
            return dict?[lang.rawValue]
        }
    }

    func localize(_ lang: AppLanguage, args: [String]) -> String? {
        let templateString = localize(lang)?.replacingOccurrences(of: "{$}", with: "%@") ?? ""
        return String(format: templateString, arguments: args).replacingOccurrences(of: "0.000000", with: "% F")
    }
}

func localizeNumber(_ appLang: AppLanguage, str: String) -> String {
    appLang == .Eng ? convertNumberMmToEng(str) : convertNumberEngToMm(str)
}

func localizeTime(_ appLang: AppLanguage, str: String) -> String {
    guard appLang == .Mm else { return str }
    let arr = str.split(separator: " ")
    guard let time = arr.first else { return "" }
    let localizedNumber = localizeNumber(appLang, str: "\(time)")
    return "\(localizedNumber) နာရီ"
}

func convertNumberEngToMm(_ engText: String) -> String {
    var mmText = ""
    for char in engText {
        switch char {
        case "0": mmText.append("၀")
        case "1": mmText.append("၁")
        case "2": mmText.append("၂")
        case "3": mmText.append("၃")
        case "4": mmText.append("၄")
        case "5": mmText.append("၅")
        case "6": mmText.append("၆")
        case "7": mmText.append("၇")
        case "8": mmText.append("၈")
        case "9": mmText.append("၉")
        default: mmText.append(char)
        }
    }
    return mmText.isEmpty ? engText : mmText
}

func convertNumberMmToEng(_ mmText: String) -> String {
    var engText = ""
    for char in mmText {
        switch char {
        case "၀": engText.append("0")
        case "၁": engText.append("1")
        case "၂": engText.append("2")
        case "၃": engText.append("3")
        case "၄": engText.append("4")
        case "၅": engText.append("5")
        case "၆": engText.append("6")
        case "၇": engText.append("7")
        case "၈": engText.append("8")
        case "၉": engText.append("9")
        default: engText.append(char)
        }
    }
    return engText.isEmpty ? mmText : engText
}
