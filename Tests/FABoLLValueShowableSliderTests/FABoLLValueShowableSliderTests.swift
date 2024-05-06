import XCTest
@testable import FABoLLValueShowableSlider

final class FABoLLValueShowableSliderTests: XCTestCase {

    // MARK: - Static Properties

    static var allTests = [
        ("testSetup", testSetup),
    ]

    // MARK: - Properties

    private let base = UIView(frame: UIScreen.main.bounds)

    private let valueShowableSlider = FABoLLValueShowableSlider()

    private let label = UILabel()

    private func wait(_ time: TimeInterval) {
        let expectation: XCTestExpectation = XCTestExpectation.init(description: "delay")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: time + 1)
    }

    // MARK: - tests

    override func setUp() {
        super.setUp()
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
    }

    func testSetup() {
        let settings = FABoLLValueShowableSliderSettings(
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
    }

    @MainActor func testSetupCanChangeTapped() {
        let settings = FABoLLValueShowableSliderSettings(
            label: label,
            isRoundedCorner: true,
            valueToString: { value in
                return String(format: "%d", Int(value * 100)) + "%"
            },
            canChangeTapped: true
        )
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
        wait(0.5)
        valueShowableSlider.tapJudging.ended(point)
        // The value does not change because it is judged as a long tap
        XCTAssertEqual(label.text, "50%")
        wait(0.5)

        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        // The value does not change because it is judged as a long tap
        XCTAssertEqual(label.text, "50%")
        wait(0.5)

        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        wait(0.2)
        // The value changes
        XCTAssertEqual(valueShowableSlider.value, 0.25)
        XCTAssertEqual(label.text, "25%")
        wait(0.5)

        point = CGPoint(
            x: valueShowableSlider.bounds.width * 0.75,
            y: valueShowableSlider.bounds.height * 0.5
        )
        valueShowableSlider.tapJudging.began(valueShowableSlider, point)
        valueShowableSlider.tapJudging.ended(point)
        wait(0.2)
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
        wait(0.2)
        // The value does not change because it is judged as a pan gesture
        XCTAssertEqual(valueShowableSlider.value, 0.75)
        XCTAssertEqual(label.text, "75%")
    }
}
