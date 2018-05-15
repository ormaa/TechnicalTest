//
//  Label.swift
//  
//
//  Created by Olivier Robin on 28/08/2017.
//  Copyright © 2017 ormaa. All rights reserved.
//

import Foundation
import UIKit

// Display label vertically
//extension UILabel {
//    @IBInspectable
//    var rotation: Int {
//        get {
//            return 90
//        } set {
//            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
//            self.transform = CGAffineTransform(rotationAngle: radians)
//        }
//    }
//}

@IBDesignable
class Label: UILabel {
    
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    @IBInspectable var underlined: Bool = false {
        didSet {
            if text != nil {
                attributedText = NSAttributedString(string: text!, attributes:
                                [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
            }
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let radians = CGFloat(CGFloat(Double.pi) * CGFloat(90) / CGFloat(180.0))
//        transform = CGAffineTransform(rotationAngle: radians)
    }
    
}
