//
//  Status.swift
//  Todo
//
//  Created by Tammy on 16/5/19.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

class Status: NSObject {
    var id:Int
    var avatar:String//图片的地址，不联网的下为图片的名字
    var timeStamp:Int64//时间戳
    var todoTime: Int64//指定的时间
    var content:String//内容
    var userID:Int//作者的ID
    var locationID:Int //地点的ID
    var likeCount:Int //喜欢的数量
    var commentCount:Int //评论的数量
    var typeID: Int //类型的ID
    init(id:Int,avatar:String,timeStamp:Int64,todoTime:Int64,content: String,
         userID:Int, locationID: Int, likeCount:Int, commentCount: Int, typeID: Int) {
        self.id = id
        self.avatar = avatar
        self.timeStamp = timeStamp
        self.todoTime = todoTime
        self.content = content
        self.userID = userID
        self.locationID = locationID
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.typeID = typeID
    }
}
