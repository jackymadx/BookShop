//
//  SecondViewController.swift
//  Project2
//
//  Created by UserMOL on 18/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController ,
UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var titleLabel     : UILabel!
    @IBOutlet weak var subTitleLabel  : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    
    var galleryItems:[GalleryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("File Path : \(#file)")
        print("Function: \(#function), line: \(#line)")
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Second View")
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.titleView = setTitle("Bee Book", subtitle: "Discount 10%")
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Delete2"), for: .normal)
        //button.setTitle("Categories", for: .normal)
        button.addTarget(self, action: #selector(self.backButton), for: .touchUpInside)
        button.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
       
        initGalleryItems()
        collectionView.reloadData()
    }
    
    func backButton(){
        //navigationController!.popToViewController(navigationController!.viewControllers[0], animated: false)
        
        guard let controllers = navigationController?.viewControllers else { return }
        let count = controllers.count
        
        if count > 2 {
            // Third from the last is the viewController we want
            if let firstVC = controllers[count - 2] as? FirstViewController {
                // pass back some data
                navigationController?.popToViewController(firstVC, animated: true)
            }
        }
       
    }
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {
        /*
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController else {
            print("Could not instantiate view controller with identifier of type FirstViewController")
            return
        }
        */
       
        guard let controllers = navigationController?.viewControllers else { return }
        let count = controllers.count
        
        if count > 2 {
            // Third from the last is the viewController we want
            if let firstVC = controllers[count - 2] as? FirstViewController {
                // pass back some data
                navigationController?.popToViewController(firstVC, animated: true)
            }
        }
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

    
    @IBAction func closeAction(_ _sender : AnyObject){
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        
        cell.setGalleryItem(galleryItems[indexPath.row])
        cell.itemLabel.text = galleryItems[indexPath.row].itemImage;
        cell.itemLabel.backgroundColor = UIColor.lightGray;
        
        return cell
        
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
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(120))
    }
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 15.0
        return UIEdgeInsetsMake(10,5,10,leftRightInset)
    }
    
}
