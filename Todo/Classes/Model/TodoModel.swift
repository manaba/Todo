//
//  TodoModel.swift
//  Todo
//
//  Created by Tammy on 16/5/28.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    
    var id = String()
    var title = String()
    var image = String()
    
    init(id :String,title:String,image:String) {
        self.id = id
        self.title = title
        self.image = image
    }
    
}

