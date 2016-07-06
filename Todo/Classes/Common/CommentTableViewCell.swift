//
//  CommentTableViewCell.swift
//  Todo
//
//  Created by Tammy on 16/5/21.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    //头像
    //昵称
    //时间
    //comment
    var avatarImg = UIImageView()
    var nameLabel = UILabel()
    var timeLabel = UILabel()
    var commentLabel = UILabel()
    
    
    //需要重写
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //self.sizeToFit()
        
        setupUI()
        //lblTitle = UILabel(frame: CGRectZero)
        //lblTitle.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        //lblTitle.textAlignment = NSTextAlignment.Left
        //lblTitle.numberOfLines = 1
        //lblTitle.backgroundColor = UIColor.clearColor()
        //lblTitle.textColor = UIColor(red: 130/255, green: 137/255, blue: 141/255, alpha: 1.0)
        //self.contentView.addSubview(self.lblTitle)
        // 130 137 141
        self.separatorInset = UIEdgeInsets(top: 0, left: -100, bottom: 0, right: -100)
        self.layoutMargins = UIEdgeInsetsZero
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        //添加子控件
        avatarImg.image = UIImage(named: "icon_profile")
        contentView.addSubview(avatarImg)
        nameLabel.text = "Tammy"
        self.nameLabel.font = UIFont(name: "Helvetica", size: 12.0)
        nameLabel.textAlignment = NSTextAlignment.Left
        contentView.addSubview(nameLabel)
        timeLabel.text  = "2015-09-18 18:00"
        timeLabel.font = UIFont(name: "Helvetica", size: 10.0)
        contentView.addSubview(timeLabel)
        commentLabel.text = "daswadxwa bhabjhbdjwha bwhjadbjhv wajhvwdhjv dwaadawda"
        commentLabel.numberOfLines = 0
        contentView.addSubview(commentLabel)
    }
    
    override func layoutSubviews() {
        
        var marginX = CGFloat(10.0)
        var marginY = CGFloat(10.0)
        var width = avatarImg.image?.size.width
        var height = avatarImg.image?.size.height
        
        //self.lblTitle.frame = CGRectMake(marginX, marginY, width, height)
        self.avatarImg.frame = CGRectMake(marginX, marginY, width!, height!)
        
        //self.nameLabel.alignmentRectForFrame(avatarImg.frame)
        
        self.nameLabel.frame = CGRectMake(marginX+width!+10, marginY, 100, 15)
        
        self.timeLabel.frame = CGRectMake(marginX+width!+10, marginY+15, 100, 10)
        
        self.commentLabel.frame = CGRectMake(marginX+width!+10, marginY+15+10, 100, 30)
        
        contentView.sizeToFit()
    }
}
