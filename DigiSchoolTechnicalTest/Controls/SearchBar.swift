//
//  SearchBar.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SearchBar: UISearchBar {
    
    @IBInspectable var realHeight: CGFloat = 0 {
        didSet {
            //if #available(iOS 11.0, *) {
                heightAnchor.constraint(equalToConstant: realHeight).isActive = true
            //}
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
    }
    
}
