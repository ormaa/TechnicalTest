//
//  TextView.swift
//  DigiSchoolTechnicalTest
//
//  Created by Olivier on 15/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextView: UITextView{
    
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
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//    }
    
    #if !TARGET_INTERFACE_BUILDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //listenForTextChangedNotifications()
    }
    
    /** Override common init, for manual allocation */
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        //listenForTextChangedNotifications()
    }
    #endif
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
}
