//
//  FABoLLValueShowableSlider
//
//  © 2023 Masakiyo Tachikawa
//

import UIKit

public class FABoLLValueShowableSlider: UISlider {

    // MARK: - Properties

    let tapJudging: FABoLLValueShowableSliderTapJudging = .init()

    private(set) var settings: FABoLLValueShowableSliderSettings = .init(label: UILabel())

    private var thumbnail: UIImageView?

    public override var value: Float {
        didSet {
            settings.label.text = settings.valueToString(value)
        }
    }

    // MARK: - Life cycle

    deinit {
        print("FABoLLValueShowableSlider released")
    }

    // MARK: - override

    public override func layoutSubviews() {
        super.layoutSubviews()
        setThumbnail()
        setLabel()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !settings.canChangeTapped { return }
        guard let point: CGPoint = touches.first?.location(in: self) else { return }
        tapJudging.began(self, point)
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateLabel()
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !settings.canChangeTapped { return }
        guard let point: CGPoint = touches.first?.location(in: self) else { return }
        tapJudging.ended(point)
    }

    // MARK: - Conveniences

    public func setLabel(settings: FABoLLValueShowableSliderSettings) {
        self.settings = settings
    }

    private func setLabel() {
        settings.label.isUserInteractionEnabled = false
        updateLabel()
        if settings.isRoundedCorner {
            settings.label.clipsToBounds = true
            settings.label.layer.cornerRadius = settings.label.frame.width * 0.5
        }
        if let frame: CGRect = thumbnail?.frame {
            settings.label.frame = CGRect(
                origin: CGPoint(
                    x: frame.origin.x + settings.padding.left,
                    y: frame.origin.y + settings.padding.top
                ),
                size: CGSize(
                    width: frame.width - (settings.padding.left + settings.padding.right),
                    height: frame.height - (settings.padding.top + settings.padding.bottom)
                )
            )
        }
        addSubview(settings.label)
        bringSubviewToFront(settings.label)
    }

    private func updateLabel() {
        if let x: CGFloat = thumbnail?.frame.origin.x {
            settings.label.frame.origin.x = x + settings.padding.left
        }
        settings.label.text = settings.valueToString(value)
    }

    private func setThumbnail() {
        thumbnail = subviews.filter {
            guard let imageView = $0 as? UIImageView, currentThumbImage?.size == imageView.image?.size else {
                return false
            }
            return true
        }
        .first as? UIImageView

        if thumbnail == nil {
            thumbnail = subviews[0].subviews.filter {
                guard let imageView = $0 as? UIImageView, currentThumbImage?.size == imageView.image?.size else {
                    return false
                }
                return true
            }
            .first as? UIImageView
        }
    }
}
