//
//  FirstViewController.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit


class FirstViewController: UIViewController ,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var startButton : UIButton! ////Your Interface builder Element
    @IBOutlet weak var firstLabel  : UILabel! ////Your Interface builder Element
    @IBOutlet weak var secondLabel  : UILabel! ////Your Interface builder Element
    @IBOutlet weak var thirdLabel   : UILabel! ////Your Interface builder Element
    @IBOutlet weak var fourthLabel  : UILabel! ////Your Interface builder Element
    @IBOutlet weak var firstView    : UIView!
    @IBOutlet weak var secondView   : UIView!
    @IBOutlet weak var imgView      : UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var galleryItems:[GalleryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("First View")
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.titleView = setTitle("Bee Books", subtitle:"Read ...")
        
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Next", style:
            UIBarButtonItemStyle.plain, target: self, action:#selector(self.startAction(_:)))
        
        
        logButton.setTitleTextAttributes([
            NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 15)!,
            NSForegroundColorAttributeName : UIColor.white],
                                         for: UIControlState.normal)

        self.navigationItem.rightBarButtonItem = logButton
        
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        firstView.layer.shadowColor  = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        firstView.layer.shadowOffset = CGSize(width:1.0, height:2.0)
        firstView.layer.shadowOpacity = 1.0
        firstView.layer.shadowRadius  = 0.0
        firstView.layer.masksToBounds = false
        
        secondView.layer.borderWidth = 0.0
        secondView.layer.masksToBounds = false
        secondView.layer.cornerRadius = 5
    
        initGalleryItems()
        collectionView.reloadData()

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

    
        
    @IBAction func startAction(_ sender : AnyObject){
        print("First view >>>")
        // Do any additional setup after loading the view, typically from a nib.
      
        
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentViewController") as! PresentViewController
       // self.present(vc, animated: true, completion: nil)
        
        
        print("File Path : \(#file)")
        print("Function: \(#function), line: \(#line)")
        
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            print("Could not instantiate view controller with identifier of type SecondViewController")
            return
        }
    
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        self.navigationItem.title = nil
        
        print("File Path : \(#file)")
        print("Function: \(#function), line: \(#line)")
        
        if segue.identifier == "SeondViewController" {
            _ = segue.destination as! SecondViewController
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        
        cell.setGalleryItem(galleryItems[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // MARK: -
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentViewController") as! PresentViewController
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // Swift 3.0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(120))
    }
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 15.0
        return UIEdgeInsetsMake(5,5,10,leftRightInset)
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

}

