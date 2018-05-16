//
//  DetailsViewController+Keyboard.swift
//  DigiSchoolTechnicalTest
//
//  Created by Olivier on 16/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit


extension DetailsViewController: UITextViewDelegate {
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide , object: nil)
    }
    
    // Keybord appear event
    // will calculate keyboard size, textView position,
    // and delta Y to apply to the scrollview to see the textView
    //
    @objc func keyboardWillAppear(notification: NSNotification?) {
        
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        // Compute y position of the textView : myReviewText, from top of screen
        // TODO : enh : texview could be a généric control, and externql to this.
        
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
        
        //print("yTotal " + String(describing: yTotal))
        //print(view.contentScaleFactor)
        
        // Compute keyboard height
        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        //print("Keybord height : " + String(describing: keyboardHeight))
        
        let screenSize: CGRect = UIScreen.main.bounds
        //print(screenSize)
        
        // move the scroll view
        let delta = screenSize.height - yTotal
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight - delta )
    }
    
    @objc func keyboardWillDisappear(notification: NSNotification?) {
        // Reset scrollview position
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    
    
    
    
    /// textView
    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //    }
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //    }
    
    // hide or not the placeholder, when text is netered, or deleted
    //
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
            return false
        }
        return true
    }
    
    
}
