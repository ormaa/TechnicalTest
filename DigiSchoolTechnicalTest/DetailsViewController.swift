//
//  DetailsViewController.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: ImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var criticsStars: UILabel!
    @IBOutlet weak var AudienceStars: UILabel!
    
    @IBOutlet weak var myReviewStars: UILabel!
    @IBOutlet weak var myReviewText: TextView!
    @IBOutlet weak var sysnopsisText: TextView!
    @IBOutlet weak var castingText: TextView!
    @IBOutlet weak var similarMoviesText: TextView!
    
    
    var detailsViewModel: DetailsViewModel? = nil
    
    override func viewDidLoad() {

        //gesture recognisers
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        // override with custom navigation bar
        navigationController?.navigationBar.addSubview(DetailsBar_View.instanceFromNib(width: self.view.frame.width))
    
    }
    override func viewWillAppear(_ animated: Bool) {
        displayDetails()
    }
    
    
    
    // define the dependencies
    //
    func injectDependencies(viewModel: DetailsViewModel) {
        self.detailsViewModel = viewModel
    }
    
    
    // display all details controls
    //
    func displayDetails() {
        if detailsViewModel != nil &&
            detailsViewModel!.moviesItem != nil {
                
            if detailsViewModel!.moviesItem!.poster != nil {
                detailsViewModel?.getPosterImage(imageURLString: detailsViewModel!.moviesItem!.poster!, completion: { (error, data) in
                    guard error == "" else {
                        // error : web or parsing error
                        Tools().simpleAlert(message: Errors.ImageError + error)
                        return
                    }
                    if data != nil {
                        let img = UIImage(data: data!)
                        if img != nil {
                            DispatchQueue.main.async {
                                //self.poster.image = img
                            }
                        }
                    }
                })
            }
            
            movieTitle.text = detailsViewModel!.moviesItem!.title
            
        }
    }
    
    // handle swipe gesture
    //
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
//            self.performSegue(withIdentifier: "popDetailsSegue", sender: nil)
            self.navigationController?.popViewController(animated: true)

        }

    }
}
