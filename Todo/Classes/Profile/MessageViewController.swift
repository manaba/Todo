//
//  MessageViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/30.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit
import Alamofire

class MessageViewController: UIViewController,UITableViewDataSource {
    var userId:Int = -1
    
    var todos:NSArray = []
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 定义一个 activityIndicatorView
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 50, 250, 100, 100)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = UIColor.blackColor()
        self.view.addSubview(activityIndicatorView)
        
        userId = NSUserDefaults.standardUserDefaults().valueForKey("UserIDKey") as! Int
        
        todos = [
        ]
        
        self.tableView.dataSource = self

        
        loadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todos.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("messageCell")! as UITableViewCell
        let message = todos[indexPath.row]
        let avatar = cell.viewWithTag(101) as! UIImageView
        let name = cell.viewWithTag(102) as! UILabel
        let time = cell.viewWithTag(103) as! UILabel
        let content = cell.viewWithTag(104) as! UILabel
        let originalStatus = cell.viewWithTag(105) as! UILabel
        
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
        
        //avatar.image = UIImage(named: message["avatar"]!)
        if (message["avatar"] != nil){
            avatar.kf_setImageWithURL(NSURL(string: message["avatar"]! as! String)!, placeholderImage: UIImage(named: "avatar_default"))
        }
        
        
        name.text = message["name"] as! String
        time.text = message["timestamp"] as! String
        content.text = "Got interested in this status"
        originalStatus.text = message["text"] as! String
        
        
        return cell
    }
    
    func loadData(){
        activityIndicatorView.startAnimating()
        let parameters = [
            "action":"message",
            "userId":userId
        ]
        
        print(parameters)
        
        Alamofire.request(.GET,URL,parameters:parameters as! [String : AnyObject]).responseJSON() {
            response in
            guard let JSON = response.result.value else { return }
            //self.activityIndicatorView.stopAnimating()
            print("JSON: \(JSON)")
            let code : Int = JSON.objectForKey("code") as! Int
            self.activityIndicatorView.stopAnimating()
            
            
            if(code==1){
                self.todos = JSON.objectForKey("array")! as! NSArray
                self.tableView.reloadData()
                
            }
            
            //            //let uid : Int = JSON.objectForKey("userId") as! Int
            //            let message : String = JSON.objectForKey("message")! as! String
            
            
        }
        
        
    }
    
    @IBAction func didTapContact(sender: AnyObject) {
        
            (sender as! UIButton).enabled = false
            let content:UIView = (sender as! UIButton).superview! as UIView
            let cell = content.superview as! UITableViewCell
            let index = self.tableView.indexPathForCell(cell)! as NSIndexPath
            
            print(index.row)
            
            var userId2 = todos[index.row]["userId"]
            var tdId = todos[index.row]["tdId"]
            print(index.row)
            let parameters = [
                "action":"contact",
                "userId1": userId,
                "userId2":todos[index.row]["userId"],
                "tdId": todos[index.row]["tdId"]
            ]
            
            print(parameters)
            
            //let url = "http://172.30.131.212:8080/TODO/Register"
            
            Alamofire.request(.GET,URL,parameters:parameters as! [String : AnyObject]).responseJSON() {
                response in
                guard let JSON = response.result.value else { return }
                //self.activityIndicatorView.stopAnimating()
                print("JSON: \(JSON)")
                let code : Int = JSON.objectForKey("code")! as! Int
                if(code==1){
                    //self.todos = JSON.objectForKey("array")! as! NSArray
                    //self.tableView.reloadData()
                }else{
                    
                }
                //            //let uid : Int = JSON.objectForKey("userId") as! Int
                //            let message : String = JSON.objectForKey("message")! as! String
                
                
            }
       

    }
    
}
