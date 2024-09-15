//
//  AnalysisScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-15.
//

import Charts
import SwiftUI

struct AnalysisScreen: View {
    @EnvironmentObject var preferences: UserPreferences
    @State private var waterConsumptionData = generateLast8HoursWaterConsumption()

    @State private var phase1: CGFloat = 0
    @State private var phase2: CGFloat = 0

    // Timer to animate the waves
    private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    WaterCardView()

                    WalkCardView()
                }

                HStack(spacing: 20) {
                    VStack(spacing: 20) {
                        CardView(title: .calories, value: localizeNumber(preferences.appLang, str: "510.43"), footer: .kcol)

                        CardView(title: .sleep, value: "08:00", footer: .hours)
                    }


                    GeometryReader { geometry in
                        ZStack(alignment: .bottom) {
                            Image(.ecgBg)
                                .resizable()
                                .frame(height: geometry.size.height * 0.35)


                            VStack(alignment: .leading) {
                                LocalizedText(.heart)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.textBlack)
                                    .padding(.vertical)

                                Spacer()

                                Image(.heartEgc)
                                    .padding(.horizontal)

                                Spacer()

                                Text(localizeNumber(preferences.appLang, str: "105"))
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.appPrimary)

                                Text("bpm")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.textBlack)
                                    .padding(.bottom)
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.textGray.opacity(0.2), lineWidth: 1)
                            .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
                    )
                }
            }
            .padding()
            .navigationTitle(.title_anaylsis)
        }
    }

    @ViewBuilder
    private func CardView(title: LocalizedKey, value: String, footer: LocalizedKey) -> some View {
        VStack(alignment: .leading) {
            LocalizedText(title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.textBlack)
                .padding(.vertical)

            Text(value)
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.appPrimary)

            LocalizedText(footer)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.textBlack)
                .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.textGray.opacity(0.2), lineWidth: 1)
                .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
        )
    }

    @ViewBuilder
    private func WaterCardView() -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ZStack {
                    Wave(amplitude: 5, frequency: 1, phase: phase1)
                        .fill(.appPrimary.opacity(0.41))

                    Wave(amplitude: 8, frequency: 1, phase: phase2)
                        .fill(.appPrimary.opacity(0.41))
                }
                .frame(height: geometry.size.height * 0.6)
                .clipShape(.rect(cornerRadius: 16))
                .onReceive(timer) { _ in
                    phase1 -= 0.05
                    phase2 += 0.03
                }

                VStack(alignment: .leading) {
                    LocalizedText(.water)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.textBlack)

                    Chart {
                        ForEach(waterConsumptionData) { data in
                            BarMark(x: .value("Hours", data.hour), y: .value("ml", data.consumption))
                                .cornerRadius(20)
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .padding(.bottom)

                    LocalizedText(.x_liter, args: [localizeNumber(preferences.appLang, str: "2.1")])
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(.textWhite)
                        .padding(.bottom, 10)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.textGray.opacity(0.2), lineWidth: 1)
                .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
        )
    }

    @ViewBuilder
    private func WalkCardView() -> some View {
        VStack(alignment: .leading) {
            LocalizedText(.walk)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.textBlack)

            Spacer()

            ActivityRing(steps: 2628, progress: 0.41, ringColor: .appPrimary)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.textGray.opacity(0.2), lineWidth: 1)
                .shadow(color: .textWhite.opacity(0.4), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    NavigationStack {
        AnalysisScreen()
            .environmentObject(UserPreferences())
    }
}

struct WaterConsumption: Identifiable {
    var id = UUID()

    let hour: String // Time as hour
    let consumption: Double // Water consumption in ml
}

func generateLast8HoursWaterConsumption() -> [WaterConsumption] {
    var data: [WaterConsumption] = []
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "ha" // e.g., "10AM"

    for hourOffset in 0 ..< 8 {
        let date = calendar.date(byAdding: .hour, value: -hourOffset, to: Date())!
        let hourString = dateFormatter.string(from: date)
        let consumption = Double.random(in: 50 ... 300) // Random water consumption between 50ml and 300ml
        data.append(WaterConsumption(hour: hourString, consumption: consumption))
    }

    return data.reversed() // Optional: reverse to make data from oldest to latest
}
