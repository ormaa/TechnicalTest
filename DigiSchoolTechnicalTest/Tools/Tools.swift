//
//  Tools.swift
//  test3
//
//  Created by Olivier on 14/05/2018.
//  Copyright © 2018 ORMAA. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    
    // Display an alert popup ( modal )
    func simpleAlert(message: String) {
        
        DispatchQueue.main.async {
            // search for topmost controller
            var topController = UIApplication.shared.keyWindow?.rootViewController
            while ((topController?.presentedViewController) != nil) {
                topController = topController?.presentedViewController
            }
            let controller = topController
            
            // Define the alert box
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
            var action: UIAlertAction
            action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            controller?.present(alert, animated: true, completion: nil)
        }
    }
    
    // log value to console
    class func log(_ args: Any...) {
        
        // merge the entry params
        var str = ""
        for a in args {
            str += String(describing: a)
        }
        
        // Here I can activate or not the print to console
        print(str)
        
        // TODO : add something to save log locally, or in clipboard, or ???
    }
}
