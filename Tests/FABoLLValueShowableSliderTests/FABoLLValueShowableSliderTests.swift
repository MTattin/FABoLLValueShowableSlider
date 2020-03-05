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
}
