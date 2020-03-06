//
//  FABoLLValueShowableSlider.swift
//
//  Created by Masakiyo Tachikawa on 2020/03/05.
//  Copyright © 2020 FABoLL. All rights reserved.
//
//  Copyright 2020 Masakiyo Tachikawa
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
import UIKit
///
/// Added a text on a UISlider thumbnail
///
/// - Tag: FABoLLValueShowableSlider
///
public class FABoLLValueShowableSlider: UISlider {
    ///
    // MARK: ------------------------------ properties
    ///
    ///
    ///
    private(set) var _settings: FABoLLValueShowableSliderSettings = FABoLLValueShowableSliderSettings
        .init(
            label: UILabel.init()
        )
    public override var value: Float {
        didSet {
            self._settings.label.text = self._settings.valueToString(self.value)
        }
    }
    ///
    ///
    ///
    private var _thumbnail: UIImageView?
    ///
    // MARK: -------------------- life cycle
    ///
    ///
    ///
    deinit {
        print("ValueShowableSlider released")
    }
    ///
    /// `settings` define is [FABoLLValueShowableSliderSettings](x-source-tag://FABoLLValueShowableSliderSettings).
    ///
    public func setLabel(settings: FABoLLValueShowableSliderSettings) {
        self._settings = settings
    }
    ///
    // MARK: -------------------- override
    ///
    ///
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()
        self._thumbnail = self.subviews
            .filter { (view: UIView) -> Bool in
                guard
                    let imageView: UIImageView = view as? UIImageView,
                    self.currentThumbImage?.size == imageView.image?.size
                else {
                    return false
                }
                return true
            }
            .first as? UIImageView
        self._setLabel()
    }
    ///
    ///
    ///
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self._updateLabel()
    }
    ///
    ///
    ///
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self._updateLabel()
    }
    ///
    // MARK: -------------------- method
    ///
    ///
    ///
    private func _setLabel() {
        self._settings.label.isUserInteractionEnabled = false
        self._updateLabel()
        if self._settings.isRoundedCorner == true {
            self._settings.label.clipsToBounds = true
            self._settings.label.layer.cornerRadius = self._settings.label.frame.width * 0.5
        }
        if let frame: CGRect = self._thumbnail?.frame {
            self._settings.label.frame = CGRect.init(
                origin: CGPoint.init(
                    x: frame.origin.x + self._settings.padding.left,
                    y: frame.origin.y + self._settings.padding.top
                ),
                size: CGSize.init(
                    width: frame.width - (self._settings.padding.left + self._settings.padding.right),
                    height: frame.height - (self._settings.padding.top + self._settings.padding.bottom)
                )
            )
        }
        self.addSubview(self._settings.label)
        self.bringSubviewToFront(self._settings.label)
    }
    ///
    ///
    ///
    private func _updateLabel() {
        if let x: CGFloat = self._thumbnail?.frame.origin.x {
            self._settings.label.frame.origin.x = x + self._settings.padding.left
        }
        self._settings.label.text = self._settings.valueToString(self.value)
    }
}
