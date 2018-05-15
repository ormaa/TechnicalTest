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

    @IBOutlet var rootView: UIView!
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
    @IBOutlet weak var enterYourREviewPlaceHolder: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide , object: nil)
    }

    @objc func keyboardWillAppear(notification: NSNotification?) {
        
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        // Compute y position of the textView, from top of screen
        var completed = false
        var yTotal = CGFloat( myReviewText.frame.size.height )
        var v1: UIView? = myReviewText as UIView
        repeat {
            if v1 != nil  {
                print(v1!.frame)
                yTotal += v1!.frame.origin.y
                v1 = v1!.superview
            }
            completed = v1 == nil
        }
        while !completed
        
        print("yTotal " + String(describing: yTotal))
        print(view.contentScaleFactor)
        
        // Compute keyboard height
        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        print("Keybord height : " + String(describing: keyboardHeight))
        
//        let posTextView = view!.convert(scrollView!.frame, to: nil).origin
//        let posScrollView = view!.convert(view!.frame, to: nil).origin
//        let posRootView = view!.convert(view!.superview!.frame.origin, to: nil)
        
        //tableViewBottomLayoutConstraint.constant = keyboardHeight
        
        let screenSize: CGRect = UIScreen.main.bounds
        print(screenSize)
        
        let delta = screenSize.height - yTotal
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight - delta ) //(keyboardHeight - posTextView.y - posScrollView.y ) + posRootView.y )
        //rootView.frame.origin = CGPoint(x: 0, y: yTotal - keyboardHeight )
    }
    
    @objc func keyboardWillDisappear(notification: NSNotification?) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        //rootView.frame.origin = CGPoint(x: 0, y: 0 )
    }
    
    
    func moveViewDelta(deltaY : CGFloat) {
        
//        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//        }
        
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view!.frame = self.view!.frame.offsetBy(dx: 0, dy: -deltaY)
//        })
    }


    /// textView
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("begin editing")
        moveViewDelta(deltaY: 70)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("end editing")
        moveViewDelta(deltaY: -70)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            enterYourREviewPlaceHolder.isHidden = true
        }
        else {
            enterYourREviewPlaceHolder.isHidden = false
        }
    }
    
    // character entered in textView
    //
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            // hide the keyboard
            textView.resignFirstResponder()
            //moveViewDelta(deltaY: 0)
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
