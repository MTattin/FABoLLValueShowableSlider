//
//  FABoLLValueShowableSliderTest
//
//  © 2023 Masakiyo Tachikawa
//

import Testing
import XCTest
@testable import FABoLLValueShowableSlider

@MainActor
struct FABoLLValueShowableSliderTest {

    private let base = UIView(frame: UIScreen.main.bounds)
    private let valueShowableSlider = FABoLLValueShowableSlider()
    private let label = UILabel()

    @Test func test() async throws {
        base.addSubview(valueShowableSlider)
        valueShowableSlider.frame = CGRect(
            origin: .zero,
            size: CGSize(width: base.frame.width - 20, height: valueShowableSlider.frame.height)
        )
        valueShowableSlider.center = base.center
        label.backgroundColor = .clear
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center

        var settings = FABoLLValueShowableSliderSettings(
            label: label,
            isRoundedCorner: true,
            valueToString: { value in
                return String(format: "%d", Int(value * 100)) + "%"
            }
        )
        valueShowableSlider.setLabel(settings: settings)
        valueShowableSlider.value = 1
        XCTAssertEqual(label.text, "100%")
        valueShowableSlider.value = 0
        XCTAssertEqual(label.text, "0%")
        valueShowableSlider.value = 0.5
        XCTAssertEqual(label.text, "50%")

        settings.update(\.canChangeTapped, true)
        valueShowableSlider.setLabel(settings: settings)
        valueShowableSlider.value = 1
        XCTAssertEqual(label.text, "100%")
        valueShowableSlider.value = 0
        XCTAssertEqual(label.text, "0%")
        valueShowableSlider.value = 0.5
        XCTAssertEqual(label.text, "50%")

        // Tap testing
        var point = CGPoint(
            x: valueShowableSlider.bounds.width * 0.25,
            y: valueShowableSlider.bounds.height * 0.5
        )
        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        // The value does not change because it is judged as a long tap
        XCTAssertEqual(label.text, "50%")

        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        // The value does not change because it is judged as a long tap
        XCTAssertEqual(label.text, "50%")

        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        // The value changes
        XCTAssertEqual(valueShowableSlider.value, 0.25)
        XCTAssertEqual(label.text, "25%")

        point = CGPoint(
            x: valueShowableSlider.bounds.width * 0.75,
            y: valueShowableSlider.bounds.height * 0.5
        )
        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        // The value changes
        XCTAssertEqual(valueShowableSlider.value, 0.75)
        XCTAssertEqual(label.text, "75%")

        point = CGPoint(
            x: valueShowableSlider.bounds.width * 0.25,
            y: valueShowableSlider.bounds.height * 0.5
        )
        let point2 = CGPoint(
            x: valueShowableSlider.bounds.width * 0.5,
            y: valueShowableSlider.bounds.height * 0.5
        )
        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point2)
        // The value does not change because it is judged as a pan gesture
        XCTAssertEqual(valueShowableSlider.value, 0.75)
        XCTAssertEqual(label.text, "75%")
    }
}
