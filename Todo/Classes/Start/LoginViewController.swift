//
//  LoginViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/28.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit
import Alamofire

let UserIDKey="uid"

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    var userId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        usernameTF.leftView = UIImageView(image: UIImage(named: "user"))
        passwordTF.leftView = UIImageView(image: UIImage(named: "lockin"))
        usernameTF.leftViewMode = UITextFieldViewMode.Always
        passwordTF.leftViewMode = UITextFieldViewMode.Always
        // Do any additional se
        
//        //test
        
        
        //let first = true
        
        if(NSUserDefaults.standardUserDefaults().valueForKey("UserIDKey")==nil){
            //NSUserDefaults.standardUserDefaults().setObject(uid, forKey: "UserIDKey")
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier("mainTabBarController") as! MainTabBarController
            self.presentViewController(vc, animated: true, completion: nil)
            
        }else{
            userId =
                NSUserDefaults.standardUserDefaults().valueForKey("UserIDKey") as! Int
            print(userId as! Int)
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier("mainTabBarController") as! MainTabBarController
            self.presentViewController(vc, animated: true, completion: nil)
            //relogin()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            print("收回键盘")
            usernameTF.resignFirstResponder()
            passwordTF.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    //登录
    @IBAction func didTapLogin(sender: AnyObject) {
//        let string: NSString = "[{\"ID\":1,\"Name\":\"元台禅寺\",\"LineID\":1},{\"ID\":2,\"Name\":\"田坞里山塘\",\"LineID\":1},{\"ID\":3,\"Name\":\"滴水石\",\"LineID\":1}]"
//        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
//        options: NSJSONReadingOptions.MutableContainers) as! NSArray
//        
//        print("记录数：\(jsonArr.count)")
//        for json in jsonArr {
//            print("ID：", json.objectForKey("ID")!, "    Name：", json.objectForKey("Name")!)
//        }

        
        let parameters = [
            "action":"login",
            "email": usernameTF.text!,
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
    
    func relogin(){
        let parameters = [
            "action":"relogin",
            "userId":userId
        ]
        
        //let url = "http://172.30.131.212:8080/TODO/Register"
        
        Alamofire.request(.GET,URL,parameters:parameters as! [String : AnyObject]).responseJSON() {
            response in
            guard let JSON = response.result.value else { return }
            print("JSON: \(JSON)")
            let code : Int = JSON.objectForKey("code")! as! Int
            //let uid : Int = JSON.objectForKey("userId") as! Int
            let message : String = JSON.objectForKey("message")! as! String
            var alertView = UIAlertView()
            alertView.title = "Notice"
            alertView.message = message
            alertView.addButtonWithTitle("OK")
            alertView.cancelButtonIndex=0
            alertView.delegate=self;
            alertView.show()
            
            if(code==1){
                //NSUserDefaults.standardUserDefaults().setObject(uid, forKey: "UserIDKey")
                var sb = UIStoryboard(name: "Main", bundle:nil)
                var vc = sb.instantiateViewControllerWithIdentifier("mainTabBarController") as! MainTabBarController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
        }
        
    }
}
