//
//  FABoLLValueShowableSliderTapJudging.swift
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
/// - Tag: FABoLLValueShowableSliderTapJudging
///
class FABoLLValueShowableSliderTapJudging {
    ///
    // MARK: ------------------------------ properties
    ///
    ///
    ///
    private var _tapEnded: TimeInterval = 0.0
    ///
    ///
    ///
    private var _tapAction: (() -> Void)?
    ///
    ///
    ///
    private var _beganPoint: CGPoint = CGPoint.zero
    ///
    // MARK: -------------------- life cycle
    ///
    ///
    ///
    deinit {
        print("FABoLLValueShowableSliderTapJudging released")
    }
    ///
    // MARK: -------------------- method
    ///
    ///
    ///
    func began(_ slider: FABoLLValueShowableSlider, _ point: CGPoint) {
        let now: TimeInterval = Date.init().timeIntervalSince1970
        if now - self._tapEnded > 0.2, self._tapAction == nil {
            self._beganPoint = point
            self._tapAction = { [weak self] in
                guard let self = self else {
                    return
                }
                let value: Float = Float(point.x / slider.bounds.width) * slider.maximumValue
                slider.value = value
                slider.sendActions(for: UIControl.Event.valueChanged)
                self._tapAction = nil
            }
            ///
            /// If the tap time exceeds  0.4 seconds, it is judge as a long tap
            ///
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) { [weak self] in
                self?._tapAction = nil
            }
        }
    }
    ///
    ///
    ///
    func ended(_ point: CGPoint) {
        ///
        /// If the point is changed, release `self._tapAction`
        ///
        if self._beganPoint != point {
            self._tapAction = nil
        }
        ///
        /// If the end of the next tap is less than 0.2 seconds, it is determined as continuous tap
        ///
        let now: TimeInterval = Date.init().timeIntervalSince1970
        if now - self._tapEnded < 0.2 {
            self._tapAction = nil
        }
        self._tapEnded = Date.init().timeIntervalSince1970
        ///
        /// Delay the action to determine if the tap is continuous
        ///
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) { [weak self] in
            self?._tapAction?()
        }
    }
}
