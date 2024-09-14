//
//  HomeScreenVM.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-14.
//

import Combine
import Foundation

@Observable
class HomeScreenVM {
    var currentTime: String = "hh:mm"
    private var cancellable: AnyCancellable?

    private var dateFormatter: DateFormatter?

    init() {
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateCurrentTime()
            }
    }

    func setupFormatter(for lang: AppLanguage) {
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "hh:mm a"

        switch lang {
            case .Eng:
                dateFormatter?.locale = Locale(identifier: "en_US")
            case .Mm:
                dateFormatter?.locale = Locale(identifier: "my_MM")
        }

        updateCurrentTime()
    }

    private func updateCurrentTime() {
        if let formatter = dateFormatter {
            currentTime = formatter.string(from: Date())
        }
    }
}

