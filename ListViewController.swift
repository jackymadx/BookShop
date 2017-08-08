//
//  ListViewController.swift
//  Project2
//
//  Created by UserMOL on 20/07/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController {
    fileprivate let url = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=10/json")!
    
    //MARK: - View Life Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News and Updates"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                //print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201,200:
                    
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print("Json >>>>\(JSON)")
                }
        }
        
        //setLeftSideNavBarButton()
    }
    
    //MARK: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
