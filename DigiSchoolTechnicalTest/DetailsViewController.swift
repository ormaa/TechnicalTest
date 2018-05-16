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
    
    
    @IBOutlet weak var myStar0: UIButton!
    @IBOutlet weak var myStar1: UIButton!
    @IBOutlet weak var myStar2: UIButton!
    @IBOutlet weak var myStar3: UIButton!
    @IBOutlet weak var myStar4: UIButton!

    
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
    
    
    
    @IBAction func myReviewStarClick(_ sender: UIButton) {
        myStar0.setImage(UIImage(named: "star_black" ), for: .normal)
        myStar1.setImage(UIImage(named: "star_black" ), for: .normal)
        myStar2.setImage(UIImage(named: "star_black" ), for: .normal)
        myStar3.setImage(UIImage(named: "star_black" ), for: .normal)
        myStar4.setImage(UIImage(named: "star_black" ), for: .normal)
        
        for i in 0...sender.tag {
            let btn = getStart(tagNum: i)
            if btn != nil {
                btn!.setImage(UIImage(named: "star_yellow"), for: .normal)
            }
        }
    }
    func getStart(tagNum: Int) -> UIButton? {
        if tagNum == 0 { return myStar0 }
        if tagNum == 1 { return myStar1 }
        if tagNum == 2 { return myStar2 }
        if tagNum == 3 { return myStar3 }
        if tagNum == 4 { return myStar4 }
        return nil
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
                    }
                    
                    // Compute critics percent
                    // there can be several ratings for a movie, coming from several critics
                    // I will calculate the medium value
                    var total = 0.0
                    var nbCritics = 0.0
                    for rating in item!.ratings {
                        let valueStr = rating.Value
                        if valueStr.contains("/") {
                            let splitted = valueStr.components(separatedBy: "/")
                            if splitted[1] == "10" {
                                let value = Double(splitted[0])
                                if value != nil {
                                    total += value! * 10
                                }
                            }
                            if splitted[1] == "100" {
                                let value = Double(splitted[0])
                                if value != nil {
                                    total += value!
                                }
                            }
                        }
                        if valueStr.contains("%") {
                            let value = Double(valueStr.replacingOccurrences(of: "%", with: ""))
                            if value != nil {
                                total += value!
                            }
                        }
                        nbCritics += 1.0
                    }
                    total = total / nbCritics
                    Tools.log("Critics medium value : ", total)
                    self.critics_StarsBar.setStarsLevel(percent: CGFloat( total ))
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
