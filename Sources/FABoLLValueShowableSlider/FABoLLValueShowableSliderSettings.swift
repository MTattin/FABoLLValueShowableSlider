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
    /// Default is `true`
    ///
    let isRoundedCorner: Bool
    ///
    /// Margin between UILabel and thumbnail UIImageView
    ///
    /// Default is
    /// ```
    /// UIEdgeInsets.init(
    ///     top: 0.0,
    ///     left: 1.0,
    ///     bottom: 2.0,
    ///     right: 1.0
    /// )
    /// ```
    ///
    let padding: UIEdgeInsets
    ///
    /// Closure to make string by UISlider.value
    ///
    /// Default closure:
    /// ```
    /// { (value: Float) in
    ///     return "\(Int(value * 100.0))"
    /// }
    /// ```
    ///
    let valueToString: ((_ value: Float) -> String)
    ///
    // MARK: -------------------- life cycle
    ///
    /// - `isRoundedCorner`
    ///
    /// If you do not want a label  to round, please set `false`
    ///
    /// Default is `true`
    ///
    /// - `padding`
    ///
    /// Margin between UILabel and thumbnail UIImageView
    ///
    /// Default is
    /// ```
    /// UIEdgeInsets.init(
    ///     top: 0.0,
    ///     left: 1.0,
    ///     bottom: 2.0,
    ///     right: 1.0
    /// )
    /// ```
    ///
    /// - `valueToString`
    ///
    /// Closure to make string by UISlider.value
    ///
    /// Default closure:
    /// ```
    /// { (value: Float) in
    ///     return "\(Int(value * 100.0))"
    /// }
    /// ```
    ///
    public init(
        label: UILabel,
        isRoundedCorner: Bool? = true,
        padding: UIEdgeInsets? = UIEdgeInsets.init(
            top: 0.0,
            left: 1.0,
            bottom: 2.0,
            right: 1.0
        ),
        valueToString: ((_ value: Float) -> String)? = { (value: Float) in
            return "\(Int(value * 100.0))"
        }
    ) {
        self.label = label
        self.isRoundedCorner = isRoundedCorner!
        self.padding = padding!
        self.valueToString = valueToString!
    }
}
