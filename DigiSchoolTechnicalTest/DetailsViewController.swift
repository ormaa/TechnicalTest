//
//  DetailsViewController.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, UITextViewDelegate{
    
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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var detailsViewModel: DetailsViewModel? = nil
    
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

        displayDetails()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    func moveViewDelta(deltaY : CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view!.frame = self.view!.frame.offsetBy(dx: 0, dy: -deltaY)
        })
    }


    /// textView
    func textViewDidEndEditing(_ textView: UITextView) {
        print("begin editing")
        moveViewDelta(deltaY: 100)
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//    }
    
    // character entered in textView
    //
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            // hide the keyboard
            textView.resignFirstResponder()
            moveViewDelta(deltaY: 0)
            return false
        }
        return true
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
                // download the image
                detailsViewModel?.getPosterImage(imageURLString: detailsViewModel!.moviesItem!.poster!, completion: { (error, data) in
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
            // Set title
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
