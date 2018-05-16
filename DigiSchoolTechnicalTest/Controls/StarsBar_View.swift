//
//  StartsBars_View.swift
//  DigiSchoolTechnicalTest
//
//  Created by Olivier on 16/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit




@IBDesignable
class StarsBar_View: UIView {
    
    @IBOutlet weak var black_Stars: UIStackView!
    @IBOutlet weak var yellow_Stars: UIStackView!
    
    @IBOutlet weak var yellow_Stars_width_Constraint: NSLayoutConstraint!
    
    var contentView:UIView?
    @IBInspectable var nibName:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    // update the yellow star width, allowing to reduce the width of the star visible.
    // black stars in background will remain visible
    // give the effect of having a fine progression level on the 5 stars
    // percent is 0 to 100
    func setStarsLevel(percent: CGFloat) {
        let barWidth = 100.0   // bar width is 100 pixel in fiull view
        yellow_Stars_width_Constraint.constant = CGFloat( percent )
    }
    
}
