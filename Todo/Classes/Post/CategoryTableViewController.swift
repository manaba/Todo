//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/29.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var todo : TodoModel?
    var delegate : SelectTypeDelegate!
    var type : String = String("Category")
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        switch indexPath.row {
        case 0:
            type = "Eat"
        case 1:
            type = "Travel"
        case 2:
            type = "Sports"
        case 3:
            type = "Team"
        case 4:
            type = "Event"
        case 5:
            type = "Hang out"
        case 6:
            type = "Interest"
        default:
            type = "Other"
        }
        
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        //
        self.delegate!.selectType(type)
        todo?.title = type
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
