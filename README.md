# FABoLLValueShowableSlider

[![FABoLL](https://custom-icon-badges.herokuapp.com/badge/license-FABoLL-8BB80A.svg?logo=law&logoColor=white)]()　
[![iOS 16.0](https://custom-icon-badges.herokuapp.com/badge/iOS-16.0-007bff.svg?logo=apple&logoColor=white)]()　
[![Xcode 16.2](https://custom-icon-badges.herokuapp.com/badge/Xcode-16.2-007bff.svg?logo=Xcode&logoColor=white)]()　
[![Swift 6.0](https://custom-icon-badges.herokuapp.com/badge/Swift-6.0-df5c43.svg?logo=Swift&logoColor=white)]()

You can show a slider value on the UISlider thumbnail.  
And you can change a slider value by tap it.

# Usage

```swift
@IBOutlet weak private var valueShowableSlider: FABoLLValueShowableSlider!
```

```swift
// Create UILabel
let label = UILabel()
label.backgroundColor = .clear
label.textColor = .darkText
label.font = UIFont.systemFont(ofSize: 10)
label.adjustsFontSizeToFitWidth = true
label.minimumScaleFactor = 0.5
label.textAlignment = NSTextAlignment.center

// Create settings
let settings = FABoLLValueShowableSliderSettings(label: label)

// Set settings
valueShowableSlider.setLabel(settings: settings)
```

If you want to change size: 

```swift
let settings = FABoLLValueShowableSliderSettings(
    label: label,
    padding: UIEdgeInsets(top: -5, left: -4, bottom: -3, right: -4)
)
// OR
var settings = FABoLLValueShowableSliderSettings(label: label)
settings.update(\.padding, UIEdgeInsets(top: -5, left: -4, bottom: -3, right: -4))
```

Full parameters:

```swift
let settings = FABoLLValueShowableSliderSettings(
    label: label,
    isRoundedCorner: true,
    padding: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0),
    valueToString: { value in
        return String(format: "%d", Int(value * 100)) + "%"
    },
    canChangeTapped: true 
)
```
