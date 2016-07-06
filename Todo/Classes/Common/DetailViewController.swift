//
//  DetailViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/20.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editView: UIView!
    
    @IBOutlet weak var textfield: UITextField!

   
    
    var timestamp:String = ""
    var type:String = ""
    var name:String = ""
    var avatar:String = ""
    var interestedCount:String = ""
    var commentCount:String = ""
    var content:String = ""
    var todoId = -1;
    
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var interestedCountLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        if commentTableView.respondsToSelector(Selector("setSeparatorInset:")){
//            commentTableView.separatorInset = UIEdgeInsetsZero
//        }
//        if commentTableView.respondsToSelector(Selector("setLayoutMargins:")){
//            commentTableView.layoutMargins = UIEdgeInsetsZero
//        }
//        
//        if likesTableView.respondsToSelector(Selector("setSeparatorInset:")){
//            likesTableView.separatorInset = UIEdgeInsetsZero
//        }
//        if likesTableView.respondsToSelector(Selector("setLayoutMargins:")){
//            likesTableView.layoutMargins = UIEdgeInsetsZero
//        }
        
        nameLabel.text = name
        timestampLabel.text = timestamp
        avatarImgView.kf_setImageWithURL(NSURL(string: avatar)!, placeholderImage: UIImage(named: "avatar_default"))
        typeButton.setTitle(type, forState: UIControlState.Normal)
        contentLabel.text = content
        interestedCountLabel.text = interestedCount
        commentCountLabel.text = commentCount

        
        
        
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    
    
//    @available(iOS 2.0, *)
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
//        if cell.respondsToSelector(Selector("setLayoutMargins:")){
//            cell.layoutMargins = UIEdgeInsetsZero
//        }
//        if cell.respondsToSelector(Selector("setSeparatorInset:")){
//            cell.separatorInset = UIEdgeInsetsZero
//        }
//    }
    
    let comments = [
        ["id":"123","avatar":"avatar_default","timeStamp":"2016-05-18 09:00",
            "content":"adwui uihbaiudh uwab hajdbw jbhbdjawb jhv ahjwvdh dsada awdawd bjbjbj bjbbjbbjbjkbkjbjkbjkbj jbjbkftfutu guygiugiugiugiug ihihiohohohihoihoihio hihihvj","userName":"Tammy","location":"Tokyo"],
        ["id":"123","avatar":"avatar_default","timeStamp":"2016-05-18 09:00",
            "content":"adwui uihbaiudh uwab hajdbw jbhbdjawb jhv ahjwvdh dsada awdawd bjbjbj bjbbjbbjbjkbkjbjkbjkbj jbjbkftfutu guygiugiugiugiug ihihiohohohihoihoihio hihihvj","userName":"Tammy","location":"Tokyo"],
        ["id":"123","avatar":"avatar_default","timeStamp":"2016-05-18 09:00",
            "content":"adwui uihbaiudh uwab hajdbw jbhbdjawb jhv ahjwvdh dsada awdawd bjbjbj bjbbjbbjbjkbkjbjkbjkbj jbjbkftfutu guygiugiugiugiug ihihiohohohihoihoihio hihihvj","userName":"Tammy","location":"Tokyo"],
        ["id":"123","avatar":"avatar_default","timeStamp":"2016-05-18 09:00",
            "content":"adwui uihbaiudh uwab hajdbw jbhbdjawb jhv ahjwvdh dsada awdawd bjbjbj bjbbjbbjbjkbkjbjkbjkbj jbjbkftfutu guygiugiugiugiug ihihiohohohihoihoihio hihihvj","userName":"Tammy","location":"Tokyo"]
    ]

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return comments.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // storyboard里设计的单元格
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("commentCell")! as UITableViewCell
        let comment = comments[indexPath.row]
        let avatar = cell.viewWithTag(101) as! UIImageView
        let name = cell.viewWithTag(102) as! UILabel
        let time = cell.viewWithTag(103) as! UILabel
        let content = cell.viewWithTag(104) as! UILabel
        
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
        
        avatar.image = UIImage(named: comment["avatar"]!)
        name.text = comment["userName"]
        time.text = comment["timeStamp"]
        content.text = comment["content"]
        
        
        return cell
        
    }
    
    //收键盘
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        return true;
    }
    
    //点击其它地方收起键盘
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textfield.resignFirstResponder();
    }
    
    
    //点击其它地方
    
    func keyBoardWillShow(note:NSNotification)
    {
        
        //1
        let userInfo  = note.userInfo as! NSDictionary
        //2
        var  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //3
        var keyBoardBoundsRect = self.view.convertRect(keyBoardBounds, toView:nil)
        //4
        var keyBaoardViewFrame = editView.frame
        var deltaY = keyBoardBounds.size.height
        //5
        
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: {
                self.editView.transform = CGAffineTransformMakeTranslation(0,-deltaY)
                }, completion: nil)
            
            
        }

        
       
    }
    
    //收起键盘
    func keyBoardWillHide(note:NSNotification)
    {
        
        let userInfo  = note.userInfo as! NSDictionary
        
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        
        let animations:(() -> Void) = {
            
            self.editView.transform = CGAffineTransformIdentity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
            
            
        }else{
            
            animations()
        }
        
    }
    
    

    
}