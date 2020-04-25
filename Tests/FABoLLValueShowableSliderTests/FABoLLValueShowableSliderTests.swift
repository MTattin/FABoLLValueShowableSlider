import XCTest
@testable import FABoLLValueShowableSlider
///
/// - Tag: FABoLLValueShowableSliderTests
///
final class FABoLLValueShowableSliderTests: XCTestCase {
    ///
    // MARK: -------------------- static properties
    ///
    ///
    ///
    static var allTests = [
        ("testSetup", testSetup),
    ]
    ///
    // MARK: -------------------- properties
    ///
    ///
    ///
    private let _base: UIView = UIView.init(frame: UIScreen.main.bounds)
    private let _valueShowableSlider: FABoLLValueShowableSlider = FABoLLValueShowableSlider.init()
    private let _label: UILabel = UILabel.init()
    ///
    ///
    ///
    private func _wait(_ time: TimeInterval) {
        let expectation: XCTestExpectation = XCTestExpectation.init(description: "delay")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: time + 1.0)
    }
    ///
    // MARK: -------------------- tests
    ///
    ///
    ///
    override func setUp() {
        super.setUp()
        self._base.addSubview(self._valueShowableSlider)
        self._valueShowableSlider.frame = CGRect.init(
            origin: CGPoint.zero,
            size: CGSize.init(
                width: self._base.frame.width - 20.0,
                height: self._valueShowableSlider.frame.height
            )
        )
        self._valueShowableSlider.center = self._base.center
        self._label.backgroundColor = UIColor.clear
        self._label.textColor = UIColor.darkText
        self._label.font = UIFont.systemFont(ofSize: 10.0)
        self._label.adjustsFontSizeToFitWidth = true
        self._label.minimumScaleFactor = 0.5
        self._label.textAlignment = NSTextAlignment.center
    }
    ///
    ///
    ///
    func testSetup() {
        let settings: FABoLLValueShowableSliderSettings = FABoLLValueShowableSliderSettings.init(
            label: self._label,
            isRoundedCorner: true,
            valueToString: { (value: Float) in
                return String.init(format: "%d", Int(value * 100)) + "%"
            }
        )
        self._valueShowableSlider.setLabel(settings: settings)
        self._valueShowableSlider.value = 1.0
        XCTAssertEqual(self._label.text, "100%")
        self._valueShowableSlider.value = 0.0
        XCTAssertEqual(self._label.text, "0%")
        self._valueShowableSlider.value = 0.5
        XCTAssertEqual(self._label.text, "50%")
    }
    ///
    ///
    ///
    func testSetupCanChangeTapped() {
        let settings: FABoLLValueShowableSliderSettings = FABoLLValueShowableSliderSettings.init(
            label: self._label,
            isRoundedCorner: true,
            valueToString: { (value: Float) in
                return String.init(format: "%d", Int(value * 100)) + "%"
            },
            canChangeTapped: true
        )
        self._valueShowableSlider.setLabel(settings: settings)
        self._valueShowableSlider.value = 1.0
        XCTAssertEqual(self._label.text, "100%")
        self._valueShowableSlider.value = 0.0
        XCTAssertEqual(self._label.text, "0%")
        self._valueShowableSlider.value = 0.5
        XCTAssertEqual(self._label.text, "50%")
        ///
        /// Tap testing
        ///
        var point: CGPoint = CGPoint.init(
            x: self._valueShowableSlider.bounds.width * 0.25,
            y: self._valueShowableSlider.bounds.height * 0.5
        )
        self._valueShowableSlider.tapJudging.began(self._valueShowableSlider, point)
        self._wait(0.5)
        self._valueShowableSlider.tapJudging.ended()
        /// The value does not change because it is judged as a long tap
        XCTAssertEqual(self._label.text, "50%")
        self._wait(0.5)
        ///
        self._valueShowableSlider.tapJudging.began(self._valueShowableSlider, point)
        self._valueShowableSlider.tapJudging.ended()
        self._valueShowableSlider.tapJudging.began(self._valueShowableSlider, point)
        self._valueShowableSlider.tapJudging.ended()
        /// The value does not change because it is judged as a long tap
        XCTAssertEqual(self._label.text, "50%")
        self._wait(0.5)
        ///
        self._valueShowableSlider.tapJudging.began(self._valueShowableSlider, point)
        self._valueShowableSlider.tapJudging.ended()
        self._wait(0.2)
        /// The value changes
        XCTAssertEqual(self._valueShowableSlider.value, 0.25)
        XCTAssertEqual(self._label.text, "25%")
        self._wait(0.5)
        ///
        point = CGPoint.init(
            x: self._valueShowableSlider.bounds.width * 0.75,
            y: self._valueShowableSlider.bounds.height * 0.5
        )
        self._valueShowableSlider.tapJudging.began(self._valueShowableSlider, point)
        self._valueShowableSlider.tapJudging.ended()
        self._wait(0.2)
        /// The value changes
        XCTAssertEqual(self._valueShowableSlider.value, 0.75)
        XCTAssertEqual(self._label.text, "75%")
    }
}
