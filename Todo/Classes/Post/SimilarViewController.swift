//
//  SimilarViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/22.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire



class SimilarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    var userId:Int = -1
    var text:String = ""
    var typeId:Int = -1
    var time:String = ""
    var location:String = ""
    var jsonArr:NSArray = []
    
    
    
    //number 评论数
    var todos:NSArray = [
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
//        
        // 定义一个 activityIndicatorView
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 50, 250, 100, 100)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = UIColor.blackColor()
        self.view.addSubview(activityIndicatorView)
       
        
        userId = NSUserDefaults.standardUserDefaults().valueForKey("UserIDKey") as! Int
        
        let parameters = [
            "action":"login",
            "userId": userId,
            "text":text,
            "typeId":typeId,
            "time":time,
            "location":location
        ]
        
        print(parameters)
        
        
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
        
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tableCell")! as UITableViewCell
        let todo = todos[indexPath.row]
        let avatar = cell.viewWithTag(101) as! UIImageView
        let name = cell.viewWithTag(102) as! UILabel
        let time = cell.viewWithTag(103) as! UILabel
        let type = cell.viewWithTag(104) as! UIButton
        let content = cell.viewWithTag(105) as! UILabel
        let likeCount = cell.viewWithTag(106) as! UILabel
        let commentCount = cell.viewWithTag(107) as! UILabel
        //let interestedButton = cell.viewWithTag(108) as! UIButton
        
        //interestedButton.tag = indexPath.row
        
        
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
        
        
        avatar.kf_setImageWithURL(NSURL(string: todo["avatar"]! as! String)!, placeholderImage: UIImage(named: "avatar_default"))
        name.text = todo["name"]! as! String
        //print(todo["timestamp"])
        time.text = todo["timestamp"] as! String
        type.setTitle(todo["tag"] as! String, forState: UIControlState.Normal)
        content.text = todo["text"] as! String
        let count = todo["interested"] as! NSNumber
        likeCount.text = count.stringValue
        let count2 = todo["number"] as! NSNumber
        commentCount.text = count2.stringValue
        
        
        return cell

    }
    
    
    
    func  loadData() {
        
        activityIndicatorView.startAnimating()
        
        let parameters = [
            "action":"search",
            "userId": userId,
            "text":text,
            "typeId":typeId,
            "time":time,
            "location":location
        ]
        
        print(parameters)
        
        //let url = "http://172.30.131.212:8080/TODO/Register"
        
        Alamofire.request(.GET,URL,parameters:parameters as! [String : AnyObject]).responseJSON() {
            response in
            guard let JSON = response.result.value else { return }
            //self.activityIndicatorView.stopAnimating()
            print("JSON: \(JSON)")
            let code : Int = JSON.objectForKey("code")! as! Int
            self.activityIndicatorView.stopAnimating()
            if(code==1){
                self.todos = JSON.objectForKey("array")! as! NSArray
                if(self.todos.count==0){
                    var alertView = UIAlertView()
                    alertView.title = "Notice"
                    alertView.message = "No similar status"
                    alertView.addButtonWithTitle("OK")
                    alertView.cancelButtonIndex=0
                    alertView.delegate=self;
                    alertView.show()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    self.tableView.reloadData()
                }
            }else{
                
            }
//            //let uid : Int = JSON.objectForKey("userId") as! Int
//            let message : String = JSON.objectForKey("message")! as! String
            
                    
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var sb = UIStoryboard(name: "Main", bundle: nil)
        var vc = sb.instantiateViewControllerWithIdentifier("statusViewController") as! DetailViewController
        vc.avatar = todos[indexPath.row]["avatar"]! as! String
        vc.name = todos[indexPath.row]["name"] as! String
        vc.timestamp = todos[indexPath.row]["timestamp"] as! String
        vc.content = todos[indexPath.row]["text"] as! String
        vc.type = todos[indexPath.row]["tag"] as! String
        let count2 = todos[indexPath.row]["number"] as! NSNumber

        vc.commentCount = count2.stringValue
        let count = todos[indexPath.row]["interested"] as! NSNumber
        vc.interestedCount = count.stringValue
        
        vc.todoId = Int(todos[indexPath.row]["tdId"] as! NSNumber)
        print("tdid")
        print(vc.todoId)

        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func didTapInterested(sender: AnyObject) {
            (sender as! UIButton).enabled = false
            let content:UIView = (sender as! UIButton).superview! as UIView
            let cell = content.superview as! UITableViewCell
            let index = self.tableView.indexPathForCell(cell)! as NSIndexPath
            print(index.row)
            let parameters = [
                "action":"interested",
                "userId": userId,
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
