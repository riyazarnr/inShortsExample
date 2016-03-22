//
//  ViewController.swift
//  inShortsSample
//
//  Created by riyaz shaik on 21/03/16.
//  Copyright © 2016 riyaz. All rights reserved.
//



extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}


import UIKit
import Alamofire
import SwiftyJSON
import JLToast


class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hlTitle: UILabel!
    @IBOutlet weak var h2TextView: UITextView!
    @IBOutlet weak var shrtAuthor: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var moreatButton: UIButton!
    @IBOutlet weak var footerView: UIView!
    
    
    
    var isShown:Bool!
    
    @IBOutlet weak var webvi: UIView!
    
    
    var wevVw:UIWebView!
    
    
    override func viewWillAppear(animated: Bool) {
        self.getCyberData()
        
        self.webvi.hidden = true
        self.isShown = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.changeUI()
        
        self.wevVw = UIWebView()
        self.wevVw.frame = CGRectMake(0, 0, 0, 0)
        self.view.addSubview(wevVw)
        self.wevVw.hidden = true
        self.wevVw.alpha = 0
        
        
        
        imageView.image = UIImage(named: "1.jpg")
        
        let redPGR = UIPanGestureRecognizer(target: self, action: "panFunc:")
        self.view.addGestureRecognizer(redPGR)
        
        let gesture = UITapGestureRecognizer(target: self, action: "toggle:")
        view.userInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        
    }
    
    func toggle(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.3, delay: 5, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
            
            self.navigationController?.setNavigationBarHidden(self.navigationController?.navigationBarHidden == false, animated: true)
            
            }) { (finished: Bool) -> Void in
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    
    
    func panFunc(gesture:UIPanGestureRecognizer) {
        
        let translationInView = gesture.translationInView(gesture.view!)
        self.view.frame.origin.y = gesture.view == self.view ? -translationInView.y : view.frame.size.height - translationInView.y
        
        if gesture.state == .Began {
            
            UIView.animateWithDuration(0.6, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeScale(0.95, 0.95)
            })
        }
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            JLToast.makeText("Refreshed Sucessfully", duration: 0.8).show()
            
            if view.frame.size.height > view.frame.size.height / 2 {
                
                
                self.view.frame.origin.y = 0
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.view.transform = CGAffineTransformMakeScale(1, 1)
                })
            }
            else {
                
                print("ended2")
                
                //                self.view.frame.origin.y = 0
            }
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    
    func changeUI(){
        
        shareButton.layer.cornerRadius = 5
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = UIColor(red: 65/255, green: 151/255, blue: 255/255, alpha: 1.0).CGColor
        
        imageView.layer.cornerRadius = 0
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        // Left Menu Button
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "mmenu"), forState: .Normal)
        leftButton.frame = CGRectMake(0, 0, 28, 28)
        leftButton.addTarget(self, action: Selector("menuButtonTapped"), forControlEvents: .TouchUpInside)
        
        let leftMenuButton = UIBarButtonItem()
        leftMenuButton.customView = leftButton
        self.navigationItem.leftBarButtonItem = leftMenuButton
        
        // Right Menu Button
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "refresh"), forState: .Normal)
        rightButton.frame = CGRectMake(0, 0, 28, 28)
        rightButton.addTarget(self, action: Selector("refreshAction"), forControlEvents: .TouchUpInside)
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = rightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func refreshAction(){
        
        
        
    }
    
    func menuButtonTapped(){
        
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("menuVC") as! MenuVC
        
        
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    
    
    
    @IBAction func moreAT(sender: AnyObject) {
        
        
        print("shown",isShown)
        
        
        if(isShown == false){
            
            self.webvi.hidden = false
            
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
                
                self.webvi.frame = CGRectMake(self.webvi.frame.origin.x, 0, self.webvi.frame.width, self.containerView.frame.height)
                
                
                }) { (finished: Bool) -> Void in
            }
            self.isShown = true
            
            print("shown",isShown)

        }
            
        else{
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionCurlDown, animations: { () -> Void in
                
                self.webvi.frame = CGRectMake(self.webvi.frame.origin.x, self.webvi.frame.origin.y, 0, 0)
                }) { (finished: Bool) -> Void in
            }

            self.webvi.hidden = true
            self.isShown = false
            
            print("shown else",isShown)

        }
        
        
    }
    
    //MARK:Share
    @IBAction func shareBtnAction(sender: AnyObject) {
        
        let firstActivityItem = "Text you want"
        let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
        // If you want to put an image
        let image : UIImage = UIImage(named: "mmenu")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCyberData(){
        
        Alamofire.request(.GET, "https://cyware.co/news/feed.php").responseJSON { (response) -> Void in
            
            print("response",response.data)
            
            do {
                let anyObj = try NSJSONSerialization.JSONObjectWithData(response.data!, options: []) as! [String:AnyObject]
                
                print(anyObj)
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        }
        
    }
    
}




