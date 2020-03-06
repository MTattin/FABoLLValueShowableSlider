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
    label: label
)
///
/// Set settings
///
self._valueShowableSlider.setLabel(settings: settings)
```

If you want to change size: 

```
let settings: FABoLLValueShowableSliderSettings = FABoLLValueShowableSliderSettings.init(
    label: label,
    padding: UIEdgeInsets.init(top: -5.0, left: -4.0, bottom: -3.0, right: -4.0)
)
```

Full parameters:

```
let settings: FABoLLValueShowableSliderSettings = FABoLLValueShowableSliderSettings.init(
    label: label,
    isRoundedCorner: true,
    padding: UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 2.0, right: 0.0),
    valueToString: { (value: Float) in
        return String.init(format: "%d", Int(value * 100)) + "%"
    }
)
```
