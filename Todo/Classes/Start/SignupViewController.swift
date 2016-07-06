//
//  SignupViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/28.
//  Copyright © 2016年 Tammy. All rights reserved.
//
import Alamofire
import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        emailTF.leftView = UIImageView(image: UIImage(named:"email"))
        usernameTF.leftView = UIImageView(image: UIImage(named: "user"))
        passwordTF.leftView = UIImageView(image: UIImage(named: "lockin"))
        emailTF.leftViewMode = UITextFieldViewMode.Always
        usernameTF.leftViewMode = UITextFieldViewMode.Always
        passwordTF.leftViewMode = UITextFieldViewMode.Always
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            print("收回键盘")
            passwordTF.resignFirstResponder()
            emailTF.resignFirstResponder()
            usernameTF.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    //login
    @IBAction func didTapLogin(sender: AnyObject) {
        let parameters = [
            "action":"signup",
            "email": emailTF.text!,
            "name":usernameTF.text!,
            "password":passwordTF.text!
        ]
        
        //let url = "http://172.30.131.212:8080/TODO/Register"
        
        Alamofire.request(.GET,URL,parameters:parameters).responseJSON() {
            response in
            guard let JSON = response.result.value else { return }
            print("JSON: \(JSON)")
            let code : Int = JSON.objectForKey("code")! as! Int
            let uid : Int = JSON.objectForKey("userId") as! Int
            let message : String = JSON.objectForKey("message")! as! String
            var alertView = UIAlertView()
            alertView.title = "Notice"
            alertView.message = message
            alertView.addButtonWithTitle("OK")
            alertView.cancelButtonIndex=0
            alertView.delegate=self;
            alertView.show()
            
            if(code==1){
                NSUserDefaults.standardUserDefaults().setObject(uid, forKey: "UserIDKey")
                var sb = UIStoryboard(name: "Main", bundle:nil)
                var vc = sb.instantiateViewControllerWithIdentifier("mainTabBarController") as! MainTabBarController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
        }

    }
    

}
