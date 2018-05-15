//
//  ViewController.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import UIKit



class MainViewController: UIViewController, TableViewDelegate, SearchBarDelegate {

    
    @IBOutlet weak var mainTableView: TableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var mainViewModel = MainViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Add some space to safe area, usefull in IOS 11 which cannot resize the navigation bar height
//        if #available(iOS 11.0, *) {
//            self.additionalSafeAreaInsets.top = 12
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        // hide the activity indicator
        activityIndicator.stopAnimating()
        
        // init the tableview dependencies
        self.mainTableView.injectDependencies(mainViewModel: &self.mainViewModel, tableViewRowClickelegate: self)

        // Set a custom navigation bar
        let topBar = MainBar_View.instanceFromNib(width: self.view.frame.width)
        topBar.setSearchDelegate(delegate: self)
        topBar.searchBar.text = mainViewModel.searchedText
        navigationController?.navigationBar.addSubview(topBar)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Activity indicator
    
    func hideActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    func showActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }

    
    /// Delegates
    
    // SearchBar_View : user clicked on Search button
    //
    func searchText(text: String) {
        
        mainViewModel.searchedText = text
        if text != "" {
            showActivity()
            
            // get movies list from viewModel
            
            mainViewModel.getMoviesList(filterName: text, completion: { (error) in
                self.hideActivity()
                if error != "" {
                    // error : web or parsing error
                    Tools().simpleAlert(message: error)
                }
                else {
                    // display the movies list
                    self.mainTableView.refreshTableviewDatas()
                }
            })
        }
        else {
            // text is empty. clear list of movies
            self.mainViewModel.clearMovieItems()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    



    // TableView : user clicked on a row
    //
    func rowSelected(item: MovieItem) {

        // push a new viewController = detailsViewController
        if storyboard != nil {
            let vc: DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
            vc.injectDependencies(item: item)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    
}

