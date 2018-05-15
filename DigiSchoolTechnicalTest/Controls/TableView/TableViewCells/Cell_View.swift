//
//  RSS_Cell_View.swift
//  ORMAA RSS reader
//
//  Created by Olivier on 05/04/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

class Cell_View: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!

    var viewModel = CellViewModel()
    
    override func awakeFromNib() {
        
    }
    
    func injectDependencies(item: MovieItem) {
        self.viewModel.moviesItem = item
    }
}
