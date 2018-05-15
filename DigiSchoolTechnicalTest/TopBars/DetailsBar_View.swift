//
//  DetailsBar_View.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

//
//  TopBar_View.swift
//  TableExample
//
//  Created by Olivier on 13/05/2018.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import UIKit

class DetailsBar_View: UINavigationBar, UISearchBarDelegate {
    
    

    class func instanceFromNib(width: CGFloat) -> UIView {
        let nib = UINib(nibName: "DetailsBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        nib.frame = CGRect(x: 0, y:0, width: width, height: nib.frame.height)
        
        return nib
    }
    
    override func awakeFromNib() {

    }
    

    
}
