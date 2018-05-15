//
//  TopBar_View.swift
//  TableExample
//
//  Created by Olivier on 13/05/2018.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import UIKit


protocol SearchBarDelegate {
    func searchText(text: String)
    func refresh()
    
}

class MainBar_View: UINavigationBar, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchBarDelegate: SearchBarDelegate? = nil
    
    // Return a view linked to a XIB
    //
    class func instanceFromNib(width: CGFloat) -> MainBar_View {
        let nib = UINib(nibName: "MainBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MainBar_View
        nib.frame = CGRect(x: 0, y:0, width: width, height: nib.frame.height)
        return nib
    }
    
    override func awakeFromNib() {
        searchBar.delegate = self
        
        // define a searBar height to 44 pixel : it does not resize the search box itself, but just the box outside the searchbar !
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }
       

    func setSearchDelegate(delegate: SearchBarDelegate) {
            self.searchBarDelegate = delegate
    }
    
    @IBAction func refreshClick(_ sender: UIButton) {
        searchBarDelegate?.refresh()
    }
    
    
    // user enter text in search bar. called for each charater entered
    //
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchBarDelegate?.searchText(text: searchText)
    }
    
    // user clicked on search button
    //
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if searchBar.text != nil {
            searchBarDelegate?.searchText(text: searchBar.text!)
        }
        // remove the keyboard :o)
        searchBar.endEditing(true)
    }
    
}
