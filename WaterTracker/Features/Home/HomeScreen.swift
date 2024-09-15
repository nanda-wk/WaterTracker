//
//  HomeScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-14.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var preferences: UserPreferences
    @State private var vm = HomeScreenVM()
    @State private var phase1: CGFloat = 0
    @State private var phase2: CGFloat = 0

    // Timer to animate the waves
    private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack {
                NavBar()

                WaterGoalCard()

                StaticSection()

                VStack(spacing: 20) {
                    AppButton(title: .btn_go_to_dashboard) {}
                        .frame(width: 200)
                        .background(
                            Color.white
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
                        )

                    LocalizedText(.x_goal_motivation, args: [localizeNumber(preferences.appLang, str: "50")])
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.textGray)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
            .onAppear {
                vm.setupFormatter(for: preferences.appLang)
            }
        }
        .background(Color.blueBG)
    }

    @ViewBuilder
    private func NavBar() -> some View {
        HStack {
            VStack(alignment: .leading) {
                LocalizedText(.greeting)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.textGray)

                Text("Nanda")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textBlack)
            }

            Spacer()

            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.textWhite)
                    .shadow(color: .textWhite.opacity(0.4), radius: 10)

                Image(systemName: "bell.fill")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.appPrimary)
            }
            .notificationBadge(showBadge: true)
        }
    }

    @ViewBuilder
    private func WaterGoalCard() -> some View {
        ZStack {
            ZStack {
                Wave(amplitude: 15, frequency: 1, phase: phase1)
                    .fill(.appPrimary.opacity(0.41))

                Wave(amplitude: 5, frequency: 1, phase: phase2)
                    .fill(.appPrimary.opacity(0.41))
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 16))
            .onReceive(timer) { _ in
                phase1 -= 0.05
                phase2 += 0.03
            }

            HStack {
                VStack(spacing: 50) {
                    VStack(alignment: .leading) {
                        Text(vm.currentTime)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textBlack)
                        LocalizedText(.x_ml_x_glass, args: [
                            localizeNumber(preferences.appLang, str: "200"),
                            localizeNumber(preferences.appLang, str: "2")
                        ])
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.textGray)
                    }

                    Button {} label: {
                        LocalizedText(.btn_add_goal)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundStyle(.textBlack)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 5)
                            .background(.textWhite)
                            .clipShape(.rect(cornerRadius: 25))
                            .shadow(radius: 1)
                    }
                }
                .padding(.trailing, 30)

                Image(.waterDrop)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 122)
            }
            .padding(.top, 15)
            .padding(.bottom, 40)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.textWhite)
                .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
        )
        .padding(.bottom, 30)
    }

    @ViewBuilder
    private func StaticSection() -> some View {
        HStack {
            ZStack(alignment: .bottom) {
                Circle()
                    .stroke(.appPrimary.opacity(0.41), lineWidth: 8)

                Wave(amplitude: 12, frequency: 1, phase: phase1)
                    .fill(.appPrimary.opacity(0.41))

                Wave(amplitude: 5, frequency: 1, phase: phase2)
                    .fill(.appPrimary.opacity(0.41))

                Text("\(localizeNumber(preferences.appLang, str: "500"))ml")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textWhite)
                    .padding(.bottom, 26)
            }
            .frame(height: 160)
            .clipShape(Circle())

            VStack(alignment: .trailing) {
                VStack {
                    HStack {
                        Text(localizeTime(preferences.appLang, str: "09:00 AM"))
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.textGray)

                        ProgressView(value: 0.3)
                            .frame(width: 50)
                            .tint(.appPrimary)
                            .padding(.leading)
                    }

                    HStack {
                        Image(systemName: "drop.degreesign.slash")
                            .foregroundStyle(.red)

                        Text("\(localizeNumber(preferences.appLang, str: "100"))ml")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textBlack)

                        Spacer()

                        Text("\(localizeNumber(preferences.appLang, str: "10"))%")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.textGray)
                    }
                }
                .padding(.horizontal)
                .frame(width: 200, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.textWhite)
                        .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
                )

                VStack(alignment: .leading) {
                    LocalizedText(.target)
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundStyle(.textGray)

                    Text("\(localizeNumber(preferences.appLang, str: "2000"))ml")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textBlack)
                }
                .padding()
                .frame(width: 120, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.textWhite)
                        .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
                )
            }
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    HomeScreen()
        .environmentObject(UserPreferences())
}
