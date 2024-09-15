//
//  ActivityRing.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-15.
//

import SwiftUI

struct ActivityRing: View {
    @EnvironmentObject var preferences: UserPreferences
    var steps: Int
    var progress: Double
    var ringColor: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundStyle(ringColor)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundStyle(ringColor)
                .rotationEffect(.degrees(270.0))
                .animation(.linear(duration: 0.5), value: progress)

            VStack {
                Text(localizeNumber(preferences.appLang, str: "\(steps)"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(ringColor)

                LocalizedText(.steps_completed)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.textBlack)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ActivityRing(steps: 2628, progress: 0.45, ringColor: .appPrimary)
        .environmentObject(UserPreferences())
        .frame(width: 200)
}

#Preview("Analysis") {
    AnalysisScreen()
        .environmentObject(UserPreferences())
}
