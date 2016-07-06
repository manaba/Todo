//
//  SelectTimeViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/29.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var todo : TodoModel?
    
    var delegate : SelectTimeDelegate!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(sender: AnyObject) {
        let date:NSDate = datePicker.date
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let dateString = dateFormatter.stringFromDate(date)
        //        let alert = UIAlertView()
        //        alert.title = "Time"
        //        alert.message = dateString
        let type = dateString
        //        alert.addButtonWithTitle("Ok")
        //        alert.show()
        todo?.title = type
        self.delegate!.selectTime(type)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
}
