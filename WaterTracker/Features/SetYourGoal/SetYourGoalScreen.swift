//
//  SetYourGoalScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-17.
//

import SwiftUI

struct SetYourGoalScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var preferences: UserPreferences
    @State private var goal = "8"
    @State private var selectedOption = 0
    @State private var showDropdown = false
    @State private var searchText = ""

    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ZStack(alignment: .top) {
            Image(.shapeBg)
                .resizable()
                .padding(.trailing, 70)
                .padding(.bottom, 70)

            Image(.shapeBg2)
                .aspectRatio(contentMode: .fit)
                .offset(x: 100, y: -90)

            ScrollView {
                VStack {
                    TextField("", text: $goal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 30)
                        .keyboardType(.numberPad)

                    DropDownMenu(options: ["Number of glass", "Number of ml"], menuWdith: 300, selectedOptionIndex: $selectedOption, showDropdown: $showDropdown)

                    Spacer(minLength: 60)

                    VStack {
                        LocalizedText(.water_goal)
                            .font(.title2)
                            .fontWeight(.semibold)

                        LocalizedText(.water_goal_desc)
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundStyle(.textGray)

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.appPrimary)

                            TextField("Search Template", text: $searchText)
                                .textInputAutocapitalization(.never)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.appPrimary.opacity(0.1))
                        )
                        .padding(.vertical)

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(searchTemplates(), id: \.name) { temp in
                                GridItemCard(item: temp)
                            }
                        }
                    }
                    .padding()
                    .background(.textWhite)
                    .clipShape(.rect(cornerRadius: 28))
                }
            }
            .navigationTitle(.title_set_your_goal)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        dismiss()
                    }
                }
            }
        }
        .background(.blueBG)
    }

    @ViewBuilder
    private func GridItemCard(item: SearchTemplate) -> some View {
        VStack(alignment: .leading, spacing: 28) {
            Text(item.name)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.textGray)

            HStack(spacing: 30) {
                Text("^[\(item.amount) Glass](inflect: true)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textBlack)

                Image(systemName: item.icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .symbolRenderingMode(.multicolor)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.textGray.opacity(0.2), lineWidth: 1)
                .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    NavigationStack {
        SetYourGoalScreen()
            .environmentObject(UserPreferences())
    }
}

struct SearchTemplate {
    let name: String
    let amount: Int
    let icon: String
}

private func searchTemplates() -> [SearchTemplate] {
    [
        .init(name: "Summer time", amount: 10, icon: "tree"),
        .init(name: "Spoty", amount: 7, icon: "basketball.fill"),
        .init(name: "Snow day", amount: 5, icon: "snowflake"),
        .init(name: "Child", amount: 4, icon: "cloud.rainbow.half")
    ]
}
