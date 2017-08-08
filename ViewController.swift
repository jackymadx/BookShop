//
//  ViewController.swift
//  Project2
//
//  Created by UserMOL on 17/06/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import UIKit
import IJProgressView
import Spring
import Stripe
//import UPCarouselFlowLayout

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate , STPAddCardViewControllerDelegate {

    @IBOutlet weak var scrollView  : UIScrollView!
    @IBOutlet weak var startButton : UIButton!
    @IBOutlet weak var alertButton : UIButton!
    @IBOutlet weak var topupButton : UIButton!
    @IBOutlet weak var leftView    : UIView!
    @IBOutlet weak var leftImage   : UIImageView!
    @IBOutlet weak var leftTableView : UITableView!
    fileprivate let TopUpSegue = "TopUpViewController"
    fileprivate let NewsSegue  = "ListViewController"
    fileprivate let url = URL(string: "https://developer.apple.com/news/rss/news.rss")!
    fileprivate var isHide     = false //initially I want this to be false
    
    private var topArray = ["QR", "Map", "Payment","Info","Products"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("File Path : \(#file)")
        print("Function: \(#function), line: \(#line)")
        print("File Segue \(TopUpSegue)")
        
        self.setView(view: self.leftView, hidden: true)
        leftImage.setRounded()
        
        //self.leftTableView.delegate   = self
        //self.leftTableView.dataSource = self
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.black.cgColor , UIColor.brown.cgColor]
        
        self.leftView.layer.insertSublayer(gradient, at: 0)
        
        // Do any additional setup after loading the view, typically from a nib.
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "TopMenu"), for: .normal)
        button.addTarget(self, action: #selector(leftMenu), for: .touchUpInside)
        button.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        let button2 = UIButton(type: .system)
        button2.setTitle("Shop", for: .normal)
        button2.addTarget(self, action: #selector(shop), for: .touchUpInside)
        button2.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button2)
        
        self.navigationController?.navigationBar.topItem?.title = "Main"
        self.navigationController?.navigationBar.titleTextAttributes
        = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 20)!,
            NSForegroundColorAttributeName: UIColor.brown]
        
        //let layout = UPCarouselFlowLayout()
        //layout.itemSize = CGSizeMake(200, 200)
        //collectionView.collectionViewLayout = layout
        
        var x:Int
        x = 12
        print(x)
        
        var y:Int
        y = 2
        y = y + 10
        print(y)
        
        // make the shadow
        
        IJProgressView.shared.showProgressView(self.view)
    
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Dispatch Queue")
            IJProgressView.shared.hideProgressView()
        }

    }
    
    func shop(){
       
        let childViewController = storyboard?.instantiateViewController(withIdentifier: "FirstView") as! FirstViewController
        navigationController?.pushViewController(childViewController, animated: true)
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Dispatch Queue")
            IJProgressView.shared.hideProgressView()
        }

    }
    
   func leftMenu(sender:  AnyObject) {
        IJProgressView.shared.showProgressView(view)
        print("Function: \(#function), line: \(#line)")
    
        let deadlineTime = DispatchTime.now() + .seconds(0)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Dispatch Queue")
            IJProgressView.shared.hideProgressView()
            
            if self.isHide == false {
                
               self.setView(view: self.leftView, hidden: false)
              
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5, options: [], animations:
                {
                    self.leftView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
                
               self.isHide = true
            } else {
                
               self.setView(view: self.leftView, hidden: true)
               self.isHide = false
                
                UIView.animate(withDuration: 0.7, delay: 2.5, usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5, options: [], animations:
                {
                    self.leftView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
                
                
            }
        }
    /*
       let vc = self.storyboard?.instantiateViewController(withIdentifier:"LeftViewController")
        as! LeftViewController
    
       self.navigationController?.pushViewController(vc, animated: true)
    
    let barHeight: CGFloat     = UIApplication.shared.statusBarFrame.size.height
    let displayWidth: CGFloat  = self.leftView.frame.width
    let displayHeight: CGFloat = self.leftView.frame.height
    
    self.leftTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
    
    */
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { _ in
            view.isHidden = hidden
        }, completion: nil)
    }
    
    @IBAction func startAction(sender : AnyObject){
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello")
        IJProgressView.shared.showProgressView(view)
        print("Function: \(#function), line: \(#line)")
        
        //let childViewController = storyboard?.instantiateViewController(withIdentifier: "FirstView") as! //FirstViewController
       // navigationController?.pushViewController(childViewController, animated: true)
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Dispatch Queue")
            IJProgressView.shared.hideProgressView()
        }
    }

    @IBAction func AlertAction(_ _sender : AnyObject){
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertPresentViewController") as! AlertPresentViewController
        self.present(vc, animated: true, completion: nil)
        updateUI()
        lightOn = !lightOn
        
    }
    
    var lightOn = true
    func updateUI() {
        
        if lightOn {
            alertButton.backgroundColor = UIColor.brown
        } else {
            alertButton.backgroundColor = UIColor.lightGray
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.leftTableView.reloadData()
       // if IJProgressView() != nil {
          IJProgressView.shared.hideProgressView()
        //}
    }
    
    @IBAction func topupAction(_ _sender : AnyObject){
        print("File Path : \(#file)")
        print("Function: \(#function), line: \(#line)")
        // Do any additional setup after loading the view, typically from a nib.
        // self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        self.navigationItem.title = nil
        
        if segue.identifier == "TopupViewController" {
            _ = segue.destination as! TopupViewController
        }
        
    }
    
    func tableView(_ leftTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Called 0")
        return topArray.count
    }
    
    func tableView(_ leftTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Called 2")
       
        let cell = self.leftTableView.dequeueReusableCell(withIdentifier: "MyCell",
            for:indexPath as IndexPath)
        
        cell.textLabel!.text = "\(topArray[indexPath.row])"
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath){
        //Selection code...
        
       IJProgressView.shared.showProgressView(view)
       
       if indexPath.row == 0 {
        
        let childViewController = storyboard?.instantiateViewController(withIdentifier:"QRViewController")
        as! QRScanner
           navigationController?.pushViewController(childViewController, animated: true)
        }
        
        if indexPath.row == 1  {
            
            IJProgressView.shared.showProgressView(view)
            
            print("Function: \(#function), line: \(#line)")
            let mapViewController = storyboard?.instantiateViewController(withIdentifier:"MapViewController")
                as! MapViewController
            
            navigationController?.pushViewController(mapViewController, animated: true)
        }

        if indexPath.row == 2 {
            
            let addCardViewController      = STPAddCardViewController()
            addCardViewController.delegate = self
            // STPAddCardViewController must be shown inside a UINavigationController.
            let navigationController = UINavigationController(rootViewController: addCardViewController)
            self.present(navigationController, animated: true, completion: nil)
        }

        if indexPath.row == 3 {
            let childViewController = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
            navigationController?.pushViewController(childViewController, animated: true)
            
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                print("Dispatch Queue")
                IJProgressView.shared.hideProgressView()
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTitle(_ title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width:0, height:0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width:0, height:0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.font = UIFont.systemFont(ofSize: 10)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x:0, y:0, width:max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height:30))
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

    // MARK: STPAddCardViewControllerDelegate
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
         IJProgressView.shared.hideProgressView()
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
         IJProgressView.shared.hideProgressView()
    }
    
}
