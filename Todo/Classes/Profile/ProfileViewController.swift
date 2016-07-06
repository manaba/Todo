//
//  ProfileViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/19.
//  Copyright © 2016年 Tammy. All rights reserved.
//


import UIKit
import Alamofire


class ProfileViewController:
UITableViewController{
    
    @IBOutlet weak var profileCell: UITableViewCell!
    
    @IBOutlet weak var optionCell: UITableViewCell!
    
    @IBOutlet weak var messageCell: UITableViewCell!
    
    @IBOutlet weak var likeCell: UITableViewCell!
    
    @IBOutlet weak var settingCell: UITableViewCell!
    
    @IBOutlet weak var contactCell: UITableViewCell!
    var userId:Int = -1
    
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var recentLbl: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("ProfileViewController")
        
        //self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.dataSource = self
        
        userId = NSUserDefaults.standardUserDefaults().valueForKey("UserIDKey") as! Int
        
        print(URL)
        
        loadDate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //print("numberOfRowsInSection:" + String(section))
        if(section==0){
            return 1;
        }else if(section==1){
            return 4;
        }else {
            return 1;
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    let user = ["id":"123","name":"Tammy","avatar":"avatar_default","recentStatus":"dwqdaadadefsesf edfewfewefewf"]
    let options = [["option":"My Status","icon":"icon_mystatus"],
        ["option":"Message","icon":"icon_message"],
        ["option":"Like","icon":"icon_like_big"],
        ["option":"Like","icon":"icon_like_big"],
        ["option":"Setting","icon":"icon_setting"]]

    
    @available(iOS 2.0, *)
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //print(indexPath.row)
        //print(indexPath.section)
        let section:Int = indexPath.section
        if(section==0){
            let cell = profileCell
            let avatar = cell.viewWithTag(101) as! UIImageView
            let name = cell.viewWithTag(102) as! UILabel
            let recentStatus = cell.viewWithTag(103) as! UITextView
            
            avatar.image = UIImage(named: user["avatar"]!)
            name.text = user["name"]
            recentStatus.text = user["recentStatus"]
            return cell

        }else if(section==1){
            var cell:UITableViewCell
            
            switch  indexPath.row{
            case 0:
                cell = optionCell
            case 1:
                cell = messageCell
            case 2:
                cell = likeCell
            default:
                cell = contactCell
            }
            
            //let icon = cell.viewWithTag(101) as! UIImageView
            //let option = cell.viewWithTag(102) as! UILabel
            
            //icon.image = UIImage(named: options[indexPath.row]["icon"]!)
            //option.text = options[indexPath.row]["option"]
            return cell
        }else{
            let cell = settingCell
            //let icon = cell.viewWithTag(101) as! UIImageView
            //let option = cell.viewWithTag(102) as! UILabel
            
            //icon.image = UIImage(named: options[3]["icon"]!)
            //option.text = options[3]["option"]
            return cell
        }
    }
    
    @available(iOS 2.0, *)
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 3;
    }
    
    func loadDate(){
        
        
        let parameters = [
            "action":"profile",
            "userId":userId
        ]
        
        print(parameters)
        
        Alamofire.request(.GET,URL,parameters:parameters as! [String : AnyObject]).responseJSON() {
            response in
            guard let JSON = response.result.value else { return }
            //self.activityIndicatorView.stopAnimating()
            print("JSON: \(JSON)")
            let code : Int = JSON.objectForKey("code")! as! Int
            if(code==1){
                let avatar = JSON.objectForKey("avatar")
                self.avatarImgView.kf_setImageWithURL(NSURL(string: avatar! as! String)!, placeholderImage: UIImage(named: "avatar_default"))
                self.nameLbl.text = JSON.objectForKey("name") as! String
                
                if(JSON.objectForKey("text")==nil){
                    self.recentLbl.text = ""
                }else{
                     self.recentLbl.text = JSON.objectForKey("text") as! String
                }
                
                
            }else{
                
            }
            //            //let uid : Int = JSON.objectForKey("userId") as! Int
            //            let message : String = JSON.objectForKey("message")! as! String
            
            
        }
    }
    
}
