//
//  MenuVC.swift
//  inShortsSample
//
//  Created by riyaz shaik on 22/03/16.
//  Copyright © 2016 riyaz. All rights reserved.
//

import UIKit



class MenuVC: UIViewController {
    
    @IBOutlet weak var borderLbl: UILabel!
    
    
    var borderLabel: UILabel!
    
    
    @IBOutlet weak var closeMenu: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.borderLabel = UILabel()
        self.borderLabel.frame = CGRectMake(categoriesBtnAct.frame.origin.x,   borderLbl.frame.origin.y - 1, categoriesBtnAct.frame.size.width, 2 )
        
        self.borderLabel.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.borderLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveButtonBorder(sender: AnyObject){
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            if (!CGRectEqualToRect(self.borderLabel.frame, sender.frame)){
                
                self.borderLabel.frame = CGRectMake(sender.frame.origin.x,self.borderLbl.frame.origin.y - 1, sender.frame.size.width, 2 )
            }
            }) { (finished: Bool) -> Void in
        }
    }
    
    
    
    @IBOutlet weak var categoriesBtnAct: UIButton!
    @IBAction func settingsAct(sender: AnyObject) {
        self.moveButtonBorder(sender)
    }
    
    @IBAction func categoriesActn(sender: AnyObject) {
        self.moveButtonBorder(sender)
    }
    
    @IBAction func closeMenuView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
