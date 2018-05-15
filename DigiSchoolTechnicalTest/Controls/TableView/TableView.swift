//
//  TableView.swift
//  TableExample
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import UIKit



protocol TableViewDelegate {
    func rowSelected(item: MovieItem)
}



class TableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var mainViewModel: MainViewModel? = nil
    
    var tableViewRowClickelegate: TableViewDelegate? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // init tableview
        register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        delegate = self
        dataSource = self
        
    }
    

    
    // define the dependencies
    // inout MainViewModel is needed to save memory : it do not duplicate the datas
    //
    func injectDependencies(mainViewModel: inout MainViewModel, tableViewRowClickelegate: TableViewDelegate) {
        self.mainViewModel = mainViewModel
        self.tableViewRowClickelegate = tableViewRowClickelegate
    }
    
    // Reload tableview datas
    //
    func refreshTableviewDatas() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    
    
    // Table view area
    
    // return number of rows
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel == nil ? 0: mainViewModel!.moviesItems.count
    }
    
    // display row
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell_View
        
        if mainViewModel != nil {
            cell.title.text = mainViewModel?.moviesItems[indexPath.row].title
        }
        
        // Define the color used to highlight the cell.
        // this avoid to have to manage the highlight, unhighlight event :o)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.green // this bright color broke my eyes :o)
        cell.selectedBackgroundView = backgroundView
        
        // create the alternate colors
        if (indexPath.row % 2) == 0 {
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = UIColor(red: 0.7098, green: 0.9176, blue: 0.6157, alpha: 1.0) /* #b5ea9d */
        }
        
        return cell
    }

    
    // select row
    //
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableViewRowClickelegate?.rowSelected(item: MovieItem())
    }
    
    
}
