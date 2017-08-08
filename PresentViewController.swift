//
//  PresentViewController.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit

class PresentViewController: UIViewController {
    @IBOutlet weak var closeButton : UIButton! ////Your Interface builder Element
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start present >>>")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func closeAction(_ sender : AnyObject){
        print("Close >>>")
        // Do any additional setup after loading the view, typically from a nib.
        self.dismiss(animated: true, completion:nil)
    }

    deinit{
        print("Game is being deInitialized.");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

