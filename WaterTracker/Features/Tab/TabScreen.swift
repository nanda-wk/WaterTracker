//
//  TabScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct TabScreen: View {
    @State private var selected: TabItem = .home
    @State private var allTabs: [AnimatedTab] = TabItem.allCases.compactMap { tab in
            .init(tab: tab)
    }

    var body: some View {
        VStack {
            TabView(selection: $selected) {
                NavigationView {
                    LocalizedText(TabItem.home.title)
                }
                .tag(TabItem.home)

                NavigationView {
                    LocalizedText(TabItem.analysis.title)
                }
                .tag(TabItem.analysis)

                NavigationView {
                    LocalizedText(TabItem.settings.title)
                }
                .tag(TabItem.settings)

                NavigationView {
                    LocalizedText(TabItem.profile.title)
                }
                .tag(TabItem.profile)
            }

            CustomTabItem(allTabs)
        }
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
                                    .foregroundStyle(.white)
                                    .shadow(radius: 10)

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
                        .font(.callout)
                        .fontWeight(.medium)

                }
                .padding(.top, 10)
                .foregroundStyle(selected == tab ? .appPrimary : .textBlack)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        selected = tab
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
        .background(
            Color.textWhite
                .shadow(color: .textGray, radius: 1, x: 0, y: 0)
                .mask(Rectangle().padding(.top, -20))
        )
    }
}

fileprivate enum TabItem: String, CaseIterable, Hashable, Identifiable {
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

fileprivate struct AnimatedTab: Identifiable {
    let id = UUID()
    var tab: TabItem
    var isAnimating: Bool?
}

#Preview {
    TabScreen()
        .environmentObject(UserPreferences())
}
