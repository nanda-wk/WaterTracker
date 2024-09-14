//
//  Wave.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct Wave: Shape {
    var amplitude: CGFloat
    var frequency: CGFloat
    var phase: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midHeight = rect.height / 2
        let width = rect.width

        // Start at the bottom left
        path.move(to: CGPoint(x: 0, y: rect.height))

        // Loop through each x-value and calculate y based on the sine wave
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let normalizedAngle = relativeX * frequency * .pi * 2
            let y = midHeight + sin(normalizedAngle + phase) * amplitude

            path.addLine(to: CGPoint(x: x, y: y))
        }

        // Close the path by drawing a line to the bottom right and back to the bottom left
        path.addLine(to: CGPoint(x: width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))

        return path
    }
}

struct AnimatedWaveView: View {
    @State private var phase1: CGFloat = 0
    @State private var phase2: CGFloat = 0

    // Timer to animate the waves
    private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // First Wave
            Wave(amplitude: 20, frequency: 2, phase: phase1)
                .fill(.appPrimary)
                .frame(height: 100)
                .offset(y: 50)

            // Second Wave
            Wave(amplitude: 15, frequency: 3, phase: phase2)
                .fill(.appPrimary.opacity(0.4))
                .frame(height: 100)
                .offset(y: 50)
        }
        .onReceive(timer) { _ in
            // Update the phase to animate the waves
            phase1 -= 0.05
            phase2 += 0.03
        }
    }
}

#Preview {
    AnimatedWaveView()
}
