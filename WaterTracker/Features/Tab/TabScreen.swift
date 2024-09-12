//
//  TabScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct TabScreen: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

enum TabItem: String, CaseIterable, Hashable, Identifiable {
    case home
    case analysis
    case settings
    case profile

    var id: String {
        return self.rawValue
    }

    var title: LocalizedKey {
        switch self {
            case .home:
                return .home
            case .analysis:
                return .analysis
            case .settings:
                return .settings
            case .profile:
                return .profile
        }
    }

    var icon: Image {
        switch self {
            case .home:
                return .init(systemName: "house")
            case .analysis:
                return .init(systemName: "chart.bar.xaxis")
            case .settings:
                return .init(systemName: "gearshape")
            case .profile:
                return .init(systemName: "person")
        }
    }

    var selectedIcon: Image {
        switch self {
            case .home:
                return .init(systemName: "house")
            case .analysis:
                return .init(systemName: "chart.bar.xaxis")
            case .settings:
                return .init(systemName: "gearshape")
            case .profile:
                return .init(systemName: "person")
        }
    }
}

#Preview {
    TabScreen()
}
