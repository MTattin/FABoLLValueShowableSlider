//
//  FABoLLValueShowableSliderTapJudging
//
//  © 2023 Masakiyo Tachikawa
//

import Foundation

// MARK: - FABoLLValueShowableSliderTapJudging

@MainActor
final class FABoLLValueShowableSliderTapJudging {

    // MARK: - Properties

    private var tapEnded: TimeInterval = 0

    private var tapAction: (() -> Void)?

    private var beganPoint: CGPoint = .zero

    // MARK: - Life cycle

    deinit {
        print("FABoLLValueShowableSliderTapJudging released")
    }

    // MARK: - Conveniences

    func began(_ slider: FABoLLValueShowableSlider, _ point: CGPoint) {
        let now: TimeInterval = Date.init().timeIntervalSince1970
        guard now - tapEnded > 0.2, tapAction == nil else { return }
        beganPoint = point
        tapAction = { [weak self] in
            guard let self = self else { return }
            let value = Float(point.x / slider.bounds.width) * slider.maximumValue
            slider.value = value
            slider.sendActions(for: .valueChanged)
            slider.sendActions(for: .touchUpInside)
            self.tapAction = nil
        }
        // If the tap time exceeds  0.4 seconds, it is judge as a long tap
        Task {
            try await Task.sleep(for: .seconds(0.4))
            tapAction = nil
        }
    }

    func ended(_ point: CGPoint) {
        // If the point is changed, release `self._tapAction`
        if beganPoint != point {
            tapAction = nil
        }
        // If the end of the next tap is less than 0.2 seconds, it is determined as continuous tap
        let now: TimeInterval = Date().timeIntervalSince1970
        if now - tapEnded < 0.2 {
            tapAction = nil
        }
        tapEnded = Date().timeIntervalSince1970
        // Delay the action to determine if the tap is continuous
        Task {
            try await Task.sleep(for: .seconds(0.2))
            tapAction?()
        }
    }
}
