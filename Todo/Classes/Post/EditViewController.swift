//
//  EditViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/22.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []

protocol SelectTypeDelegate{
    func selectType(type : String)
}
protocol SelectLocationDelegate{
    func selectLocation(type : String)
}
protocol SelectTimeDelegate{
    func selectTime(type : String)
}
var dtime:NSDate = NSDate()

class EditViewController: UIViewController,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,SelectTypeDelegate,SelectLocationDelegate,SelectTimeDelegate{
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
//    var typeID:Int = 8
//    var time:String = ""
//    var location = ""
    
    override func viewDidLoad() {
        textView.text = ""
        //textView.textColor = UIColor.lightGrayColor()
        textView.becomeFirstResponder()
        textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        todos=[TodoModel(id:"1",title:"Category",image:"category"),
               TodoModel(id:"2",title:"Time",image:"time"),
               TodoModel(id:"3",title:"Location",image:"earth")]
        tableView.delegate = self
        tableView.dataSource = self
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = ""
            textView.textColor = UIColor.lightGrayColor()
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
            
        }
        func textViewDidBeginEditing(textView: UITextView) {
            let frame:CGRect = textView.frame
            let offset:CGFloat = frame.origin.y + 100 - (self.view.frame.size.height-330)
            
            if offset > 0  {
                
                self.view.frame = CGRectMake(0.0, -offset, self.view.frame.size.width, self.view.frame.size.height)
            }
            
            print("移动键盘")
        }
        func textViewDidEndEditing(textView: UITextView) {
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
            print("恢复视图")
        }
        
    }
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            print("收回键盘")
            textView.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell")! as UITableViewCell
        let todo = todos[indexPath.row] as TodoModel
        let title = cell.viewWithTag(101) as! UILabel
        let image = cell.viewWithTag(102) as! UIImageView
        
        title.text = todo.title
        image.image = UIImage(named: todo.image)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        switch indexPath.row {
        case 0:
            var sb = UIStoryboard(name: "Main", bundle: nil)
            var vc = sb.instantiateViewControllerWithIdentifier("categorycontroller") as! CategoryTableViewController
            vc.delegate = self;
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            var sb = UIStoryboard(name: "Main", bundle: nil)
            var vc = sb.instantiateViewControllerWithIdentifier("seletTimeController") as! SelectTimeViewController
            vc.delegate = self;
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            var sb = UIStoryboard(name: "Main", bundle: nil)
            var vc = sb.instantiateViewControllerWithIdentifier("mapcontroller") as! MapViewController
            vc.delegate = self;
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    
    func selectType(type: String) {
        todos[0].title = type
        tableView.reloadData()
    }
    func selectLocation(type: String) {
        todos[2].title = type
        tableView.reloadData()
        print("location")
        print(todos[2].title)
    }
    func selectTime(type: String) {
        todos[1].title = type
        tableView.reloadData()
        //dateTansform(type)
    }
    
    @IBAction func didTapBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func didTapSend(sender: AnyObject) {
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("similarViewController") as! SimilarViewController
        vc.text = textView.text
        vc.typeId = switchNameToInt(todos[0].title)
        vc.time = dateTansform(todos[1].title)
        vc.location = todos[2].title
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func switchNameToInt(name:String) -> Int {
        var type = -1
        switch name {
        case "Eat":
            type = 1
            break
        case "Travel":
            type = 2
            break
        case "Sports":
            type = 3
        case "Event":
            type = 5
            break
        case "Team":
            type = 4
            break
        case "Other":
            type = 8
            break
        case "Hang Out":
            type = 6
            break
        case "Interest":
            type = 7
            break
        default:
            type = -1
        }
        
        return type;
    }
    
    func dateTansform(date:String)->String{
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yy-MM-dd"
        var dateFromString = timeFormatter.dateFromString(date)
        timeFormatter.dateFormat = "yyyy-MM-dd"
        var dateString = timeFormatter.stringFromDate(dateFromString!)
        return dateString
    }


}
