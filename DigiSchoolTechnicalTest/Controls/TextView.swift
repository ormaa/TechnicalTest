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
class TextView: UITextView {

    
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
    

    #if !TARGET_INTERFACE_BUILDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /** Override common init, for manual allocation */
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    #endif
    
    
    

//    // Add a toolbar with a `Done` button
//    //
//    func addDoneToolbar() {
//        
//        let toolbar = UIToolbar()
//        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onToolBarDone))
//        
//        toolbar.items = [space, doneBtn]
//        toolbar.sizeToFit()
//        
//        inputAccessoryView = toolbar
//    }
//    
//    @objc func onToolBarDone(sender: Any) {
//         //resignFirstResponder()
//        self.sendActions(for: .editingDidEndOnExit)
//    }
}
