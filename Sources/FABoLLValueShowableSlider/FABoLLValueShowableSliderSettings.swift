//
//  FABoLLValueShowableSliderSettings
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

// MARK: - FABoLLValueShowableSliderSettings

public struct FABoLLValueShowableSliderSettings {

    // MARK: - Properties

    let label: UILabel
    /// If you do not want a label  to round, please set `false`.
    ///
    /// Default is `true`.
    let isRoundedCorner: Bool
    /// Margin between UILabel and thumbnail UIImageView.
    ///
    /// Default UIEdgeInsets:
    /// ```
    /// UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 1)
    /// ```
    let padding: UIEdgeInsets
    /// Closure to make string by UISlider.value.
    ///
    /// Default closure:
    /// ```
    /// { value in "\(Int(value * 100))" }
    /// ```
    let valueToString: ((Float) -> String)
    /// If you want to change a slider value by tapping, please set `true`.
    ///
    /// Default is `false`.
    let canChangeTapped: Bool

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
        valueToString: ((Float) -> String)? = { value in "\(Int(value * 100))" },
        canChangeTapped: Bool? = false
    ) {
        self.label = label
        self.isRoundedCorner = isRoundedCorner!
        self.padding = padding!
        self.valueToString = valueToString!
        self.canChangeTapped = canChangeTapped!
    }
}
