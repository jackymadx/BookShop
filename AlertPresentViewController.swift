//
//  AlertPresentViewController.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

struct msg {
    
    let firstMsg:String  = "Incomplete Transaction"
    let secondMsg:String = "Please Try Again."
}

import Foundation
import UIKit

class AlertPresentViewController: UIViewController {
    
    var alertType:Int  = 0
    var message:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("File Path : \(#file)")
        print("Alert Type  = \(alertType)")
        if alertType == 0 {
            message = msg.init().firstMsg
        } else {
            message = msg.init().secondMsg
        }
        
        // create the alert
        let alert = UIAlertController(title: "Incomplete Transaction", message:message,
            preferredStyle: UIAlertControllerStyle.alert)
        
       
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action in
            self.dismiss(animated: false, completion:nil)
        })
        
        if alertType > 0 {
            
          alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { action in
            self.dismiss(animated: false, completion:nil)
          })
        
        }
            
        // show the alert
        self.present(alert, animated: false, completion: nil)
    }
    
    deinit{
        print("Game is being deInitialized.");
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

