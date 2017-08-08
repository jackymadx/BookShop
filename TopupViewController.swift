//
//  FirstViewController.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import UIKit

class TopupViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var startButton : UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var topArray = ["RM50", "RM100", "RM200","RM300","RM500"]
    
    var galleryItems: [GalleryItem] = []
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height

        // Do any additional setup after loading the view, typically from a nib.
        print("File Path : \(#file)")
        print("Function  : \(#function), line: \(#line)")
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Online Banks"
        
        /*
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Next", style:
            UIBarButtonItemStyle.plain, target: self, action:#selector(self.startAction(_sender:)))
    
        logButton.setTitleTextAttributes([
            NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 15)!,
            NSForegroundColorAttributeName : UIColor.lightGray],
            for: UIControlState.normal)

        self.navigationItem.rightBarButtonItem = logButton
        */
        
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
    
        initGalleryItems()
        collectionView.reloadData()
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:10, right: 0)
    }
    
    fileprivate func initGalleryItems() {
        
        var items = [GalleryItem]()
        let inputFile = Bundle.main.path(forResource: "items", ofType: "plist")
        
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        
        for inputItem in inputDataArray as! [Dictionary<String, String>] {
            let galleryItem = GalleryItem(dataDictionary: inputItem)
            items.append(galleryItem)
        }
        
        galleryItems = items
    }

        
    @IBAction func startAction(_ _sender : AnyObject){
        // Do any additional setup after loading the view, typically from a nib.
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentViewController") as! PresentViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    open func setTitle(_ title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width:0, height:0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:22, width:0, height:0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        
        let titleView = UIView(frame: CGRect(x:0, y:0, width:max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height:35))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return titleView
    }
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        
        cell.amountButton.setTitle(topArray[indexPath.row], for: .normal)
        
        // make the shadow
        cell.amountButton.layer.shadowOffset =   CGSize(width: 2, height: 3)
        
        // set the radius
        cell.amountButton.layer.shadowRadius = 7
        
        // change the color of the shadow (has to be CGColor)
        cell.amountButton.layer.shadowColor = UIColor.lightGray.cgColor
        
        // display the shadow
        cell.amountButton.layer.shadowOpacity = 2.0

        
        cell.amountButton.tag = indexPath.row
        cell.amountButton.addTarget(self, action: #selector(self.yourFunc), for: .touchUpInside)
        //cell.amountButton.addTarget(self, action: #selector(self.release), for: .tou)
        
        
        return cell
        
    }
    
    @IBAction func buttonClicked(_ sender: AnyObject) { //Touch Up Inside action
     //   sender.backgroundColor = UIColor.whiteColor
    }
    
    @IBAction func buttonReleased(_ sender: AnyObject) { //Touch Down action
     //   UIButton!sender.backgroundColor = UIColor.lightGray
    }
    
    
    func release(_ sender : UIButton){
        print("Hello")
        
        sender.backgroundColor = UIColor.lightGray
    }

    
    func yourFunc(_ sender : UIButton){
        print("Hello")
        
        //sender.backgroundColor = UIColor.red
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentViewController") as! PresentViewController
        self.present(vc, animated: true, completion: nil)
        
        print("File Path : \(#file)")
        print("Function: \(#function), line: \(#line)")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // MARK: -
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertPresentViewController") as! AlertPresentViewController
        
        if indexPath.row < 4 {
           vc.alertType = 0
           print("File Path : \(#file)")
           print("Row 0")
        } else {
           vc.alertType = 1
            print("File Path : \(#file)")
            print("Row 1")
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // Swift 3.0
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(125))
    }
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 15.0
        return UIEdgeInsetsMake(5,5,10,leftRightInset)
    }
}


