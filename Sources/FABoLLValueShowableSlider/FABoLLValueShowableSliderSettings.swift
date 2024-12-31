//
//  FABoLLValueShowableSliderSettings
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

public struct FABoLLValueShowableSliderSettings: Sendable {

    // MARK: - Properties

    public private(set) var label: UILabel
    /// If you do not want a label  to round, please set `false`.
    ///
    /// Default is `true`.
    public private(set) var isRoundedCorner: Bool
    /// Margin between UILabel and thumbnail UIImageView.
    ///
    /// Default UIEdgeInsets:
    /// ```
    /// UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 1)
    /// ```
    public private(set) var padding: UIEdgeInsets
    /// Closure to make string by UISlider.value.
    ///
    /// Default closure:
    /// ```
    /// { value in "\(Int(value * 100))" }
    /// ```
    public private(set) var valueToString: (@Sendable (Float) -> String)
    /// If you want to change a slider value by tapping, please set `true`.
    ///
    /// Default is `false`.
    public private(set) var canChangeTapped: Bool

    // MARK: - Life cycle

    /// - `isRoundedCorner`
    ///
    /// If you do not want a label  to round, please set `false`.
    ///
    /// Default is `true`.
    ///
    /// - `padding`
    ///
    /// Margin between UILabel and thumbnail UIImageView.
    ///
    /// Default UIEdgeInsets:
    /// ```
    /// UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 1)
    /// ```
    ///
    /// - `valueToString`
    ///
    /// Closure to make string by UISlider.value.
    ///
    /// Default closure:
    /// ```
    /// { value in "\(Int(value * 100))" }
    /// ```
    public init(
        label: UILabel,
        isRoundedCorner: Bool? = true,
        padding: UIEdgeInsets? = UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 1),
        valueToString: (@Sendable (Float) -> String)? = { value in "\(Int(value * 100))" },
        canChangeTapped: Bool? = false
    ) {
        self.label = label
        self.isRoundedCorner = isRoundedCorner!
        self.padding = padding!
        self.valueToString = valueToString!
        self.canChangeTapped = canChangeTapped!
    }

    public mutating func update<T>(_ key: KeyPath<Self, T>, _ value: T) {
        guard let writableKey = key as? WritableKeyPath<Self, T> else {
            assertionFailure("KeyPath変換で問題発生")
            return
        }
        self[keyPath: writableKey] = value
    }
}
