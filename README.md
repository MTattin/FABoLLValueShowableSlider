# FABoLLValueShowableSlider

You can show a slider value on the UISlider thumbnail.

# License
MIT


# Dependency

- iOS, >=11
- Xcode, >= 11


# Usage

```
@IBOutlet weak private var _valueShowableSlider: FABoLLValueShowableSlider!
```

```
///
/// Create UILabel
///
let label: UILabel = UILabel.init()
label.backgroundColor = UIColor.clear
label.textColor = UIColor.darkText
label.font = UIFont.systemFont(ofSize: 10.0)
label.adjustsFontSizeToFitWidth = true
label.minimumScaleFactor = 0.5
label.textAlignment = NSTextAlignment.center
///
/// Create settings
///
let settings: FABoLLValueShowableSliderSettings = FABoLLValueShowableSliderSettings.init(
    label: label,
    isRoundedCorner: true,
    valueToString: { (value: Float) in
        return String.init(format: "%d", Int(value * 100)) + "%"
    }
)
///
/// Set settings
///
self._valueShowableSlider.setLabel(settings: settings)
```
