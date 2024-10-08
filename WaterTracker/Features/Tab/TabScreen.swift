//
//  TabScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct TabScreen: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var selected: TabItem = .home
    @State private var allTabs: [AnimatedTab] = TabItem.allCases.compactMap { tab in
        .init(tab: tab)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: self.$selected) {
                NavigationView {
                    HomeScreen()
                }
                .tag(TabItem.home)

                NavigationView {
                    AnalysisScreen()
                }
                .tag(TabItem.analysis)

                NavigationView {
                    SettingScreen()
                }
                .tag(TabItem.settings)

                NavigationView {
                    ProfileScreen()
                }
                .tag(TabItem.profile)
            }

            self.CustomTabItem(self.allTabs)
        }
        .ignoresSafeArea(edges: .bottom)
    }

    @ViewBuilder
    private func CustomTabItem(_ allTabs: [AnimatedTab]) -> some View {
        HStack(spacing: 15) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                VStack {
                    if tab == .goal {
                        NavigationLink {
                            Text("Add Goal Here")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(.textWhite)
                                    .shadow(radius: 4)

                                tab.icon
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.textBlack)
                            }
                            .offset(x: 0, y: -10)
                        }
                    } else {
                        tab.icon
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .symbolEffect(.bounce.up.byLayer, value: animatedTab.isAnimating)
                    }

                    LocalizedText(tab.title)
                        .font(preferences.appLang == AppLanguage.Eng ? .callout : .footnote)
                        .fontWeight(.medium)
                }
                .padding(.top, 10)
                .foregroundStyle(self.selected == tab ? .appPrimary : .textBlack)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        self.selected = tab
                        animatedTab.isAnimating = true
                    } completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .padding(.bottom)
        .background(
            Color.textWhite
                .shadow(color: .textGray, radius: 1, x: 0, y: 0)
                .mask(Rectangle().padding(.top, -20))
        )
    }
}

private enum TabItem: String, CaseIterable, Hashable, Identifiable {
    case home
    case analysis
    case goal
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
            case .goal:
                return .goal
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
            case .goal:
                return .init(systemName: "alarm")
            case .settings:
                return .init(systemName: "gearshape")
            case .profile:
                return .init(systemName: "person")
        }
    }
}

private struct AnimatedTab: Identifiable {
    let id = UUID()
    var tab: TabItem
    var isAnimating: Bool?
}

#Preview {
    TabScreen()
        .environmentObject(UserPreferences())
}
