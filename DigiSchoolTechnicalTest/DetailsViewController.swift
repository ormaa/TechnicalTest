//
//  DetailsViewController.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController{

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: ImageView!
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var critics_StarsBar: StarsBar_View!
    @IBOutlet weak var audience_StarsBar: StarsBar_View!
    
    
    @IBOutlet weak var myReviewStars: UILabel!
    @IBOutlet weak var myReviewText: TextView!
    @IBOutlet weak var sysnopsisText: TextView!
    @IBOutlet weak var castingText: TextView!
    @IBOutlet weak var similarMoviesText: TextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var enterYourREviewPlaceHolder: UILabel!
    
    var imdbID = ""
    var detailsViewModel = DetailsViewModel()
    
    
    
    
    override func viewDidLoad() {

        // TextView delegate, to get some needed event
        myReviewText.delegate = self
        sysnopsisText.delegate = self
        castingText.delegate = self
        similarMoviesText.delegate = self
        
        //gesture recognisers
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        // override with custom navigation bar
        navigationController?.navigationBar.addSubview(DetailsBar_View.instanceFromNib(width: self.view.frame.width))
    }
    override func viewWillAppear(_ animated: Bool) {
        
        // observer allowing to move the scrollview, when user click in Review box.
        addKeyboardObservers()
        
        requestAndDisplayDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // remove the observer to avoid multiple observer on same event
        removeKeyboardObserver()
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
    
    
    // handle swipe gesture
    //
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            //            self.performSegue(withIdentifier: "popDetailsSegue", sender: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    

    // display all details controls
    //
    func requestAndDisplayDetails() {
        
        detailsViewModel.getMovieDetails(imdbID: self.imdbID, completion: {(error) in
            guard error == "" else {
                // error : web or parsing error
                Tools().simpleAlert(message: Errors.ImageError + error)
                return
            }
            let item = self.detailsViewModel.moviesDetailsItem
            if item != nil {
                
                DispatchQueue.main.async {
                    // fill controls with details of the movie
                    self.loadImage(item: item!)
                    
                    self.movieTitle.text = item!.title
                    self.releaseDate.text = item!.releaseDate
                    self.sysnopsisText.text = item!.synopsis
                    self.castingText.text = item!.casting
                    self.similarMoviesText.text = item!.similarMovies
                    
                    // compute audience percent
                    let audiencePercent = Double(self.detailsViewModel.moviesDetailsItem!.imdbRating)
                    if audiencePercent != nil {
                        Tools.log("Audience : ", audiencePercent ?? "?")
                        self.audience_StarsBar.setStarsLevel(percent: CGFloat(audiencePercent! * 10.0))
                        self.critics_StarsBar.setStarsLevel(percent: CGFloat( 90.0))
                    }
                    
                    // Compute critics percent
                    
                }

            }
            
        })

    }
    
    // Load the poster image of the movie, and apply it to UIImageView
    //
    func loadImage(item: MovieDetailsItem) {
        if item.poster != nil && item.poster != "" {
            // download the image
            self.detailsViewModel.getPosterImage(imageURLString: detailsViewModel.moviesDetailsItem!.poster!, completion: { (error, data) in
                guard error == "" else {
                    // error : web or parsing error
                    Tools().simpleAlert(message: Errors.ImageError + error)
                    return
                }
                if data != nil {
                    let img = UIImage(data: data!)
                    if img != nil {
                        self.hideActivity()
                        DispatchQueue.main.async {
                            self.poster.image = img
                        }
                    }
                }
            })
        }
    }
    
    

}
