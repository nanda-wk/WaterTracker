//
//  Wave.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-12.
//

import SwiftUI

struct Wave: Shape {
    var progress: CGFloat // For animating the wave

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let height = rect.height
        let width = rect.width

        let waveHeight: CGFloat = 20
        let waveLength = width / 2

        // Start at the bottom left
        path.move(to: CGPoint(x: 0, y: height))

        // Draw wave using sinusoidal curves
        for x in stride(from: 0, to: width, by: 1) {
            let relativeX = x / waveLength
            let sine = sin(relativeX + progress * 2 * .pi)
            let y = waveHeight * sine + (height / 2)
            path.addLine(to: CGPoint(x: x, y: y))
        }

        // Close path
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))

        return path
    }
}

struct AnimatedWaveView: View {
    @State private var waveOffset: CGFloat = 0.0

    var body: some View {
        ZStack {
            Wave(progress: waveOffset)
                .fill(Color.blue.opacity(0.3)) // Make the wave slightly transparent
                .frame(height: 100)
                .offset(y: 150) // Positioning of the wave

            // Add a second wave with a different phase for a layered effect
            Wave(progress: waveOffset + 0.5)
                .fill(Color.blue.opacity(0.2))
                .frame(height: 100)
                .offset(y: 160)
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                waveOffset = 1.0
            }
        }
    }
}

#Preview {
    AnimatedWaveView()
}
