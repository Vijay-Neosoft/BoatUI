//
//  Slider.swift
//  BoatUI
//
//  Created by NeoSOFT on 27/11/23.
//

import UIKit

protocol InternalSliderDelegate: AnyObject {
    func draggingDidChange()
}

class InternalSlider: UISlider {

    var increment: Float = 0
    weak var delegate: InternalSliderDelegate?
    var roundedValue: Float {
        get {
            return round(super.value, to: increment)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.frame.size = self.intrinsicContentSize
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        addTarget(self, action: #selector(endSliding), for: .touchUpInside)
        addTarget(self, action: #selector(endSliding), for: .touchUpOutside)
        addTarget(self, action: #selector(touchDragInside), for: .touchDragInside)
    }
    
    @objc private func endSliding() {
        setValue(super.value, animated: true)
        sendActions(for: .valueChanged)
    }
    @objc private func touchDragInside() {
        setValue(super.value, animated: true)
        sendActions(for: .valueChanged)
        self.delegate?.draggingDidChange()
    }

}

fileprivate func round(_ value: Float, to increment: Float) -> Float {
    if increment == 0 {
        return value
    }
    
    return increment * Float(round(value / increment))
}
