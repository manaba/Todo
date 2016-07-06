//
//  ContactViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/30.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit
import Alamofire



class ContactViewController: UIViewController,UITableViewDataSource {
    
    var emails:NSArray = []
    
    var userId:Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 定义一个 activityIndicatorView
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 50, 250, 100, 100)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = UIColor.blackColor()
        self.view.addSubview(activityIndicatorView)
        
        userId = NSUserDefaults.standardUserDefaults().valueForKey("UserIDKey") as! Int
        
        loadFakeData()
        
        self.tableView.dataSource = self
        
        loadData()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFakeData(){
        emails = [
            ["avatar":"","interested":0,"name":"123","number":0,"tag":"Hung Out","tdId":35,"text":"Today","time":1464313523847,"timestamp":"1464488651132","typeId":6,"userId":0,"email":"tammy@yahoo.co.jp"],
            ["avatar":"","interested":0,"name":"123","number":0,"tag":"Hung Out","tdId":37,"text":"Today","time":1464313523847,"timestamp":"1464493178578","typeId":6,"userId":0,"email":"tammy@yahoo.co.jp"],
            ["avatar":"","interested":0,"name":"123","number":0,"tag":"Hung Out","tdId":39,"text":"Today","time":1464313523847,"timestamp":"1464493390540","typeId":6,"userId":0,"email":"tammy@yahoo.co.jp"],
            ["avatar":"","interested":0,"name":"123","number":0,"tag":"Hung Out","tdId":41,"text":"Today","time":1464313523847,"timestamp":"1464494242092","typeId":6,"userId":0,"email":"tammy@yahoo.co.jp"],
            ["avatar":"","interested":0,"name":"123","number":0,"tag":"Hung Out","tdId":43,"text":"Today","time":1464313523847,"timestamp":"1464494624223","typeId":6,"userId":0,"email":"tammy@yahoo.co.jp"]
        ]
    }
    
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return emails.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("emailCell")! as UITableViewCell
        let message = emails[indexPath.row]
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
        //content.text = "Got interested in this status"
        content.text = message["email"] as! String
        originalStatus.text = message["text"] as! String
        
        
        return cell
    }
    
    func loadData(){
        activityIndicatorView.startAnimating()
        
        let parameters = [
            "action":"email",
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
                self.emails = JSON.objectForKey("array")! as! NSArray
                self.tableView.reloadData()
                
            }
            
            //            //let uid : Int = JSON.objectForKey("userId") as! Int
            //            let message : String = JSON.objectForKey("message")! as! String
            
            
        }
    }
    
    

}

