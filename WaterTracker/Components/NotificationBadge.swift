//
//  NotificationBadge.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-15.
//

import SwiftUI

struct NotificationBadge: ViewModifier {
    var showBadge: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content

            if self.showBadge {
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .offset(x: 0, y: 0)
            }
        }
    }
}

extension View {
    func notificationBadge(showBadge: Bool) -> some View {
        self.modifier(NotificationBadge(showBadge: showBadge))
    }
}
