//
//  FABoLLValueShowableSliderSettings.swift
//
//
//  Created by Masakiyo Tachikawa on 2020/03/04.
//
import UIKit
///
/// - Tag: FABoLLValueShowableSliderSettings
///
public struct FABoLLValueShowableSliderSettings {
    ///
    // MARK: -------------------- properties
    ///
    ///
    ///
    let label: UILabel
    ///
    /// If you do not want a label  to round, please set `false`
    ///
    let isRoundedCorner: Bool
    ///
    /// Closure to make string by UISlider.value
    ///
    /// Default closure:
    /// ```
    /// { (value: Float) in
    ///     return "\(value)"
    /// }
    /// ```
    ///
    let valueToString: ((_ value: Float) -> String)
    ///
    // MARK: -------------------- life cycle
    ///
    ///
    ///
    public init(
        label: UILabel,
        isRoundedCorner: Bool? = true,
        valueToString: ((_ value: Float) -> String)? = { (value: Float) in
            return "\(value)"
        }
    ) {
        self.label = label
        self.isRoundedCorner = isRoundedCorner!
        self.valueToString = valueToString!
    }
}
