//
//  MainTabBarController.swift
//  Todo
//
//  Created by Tammy on 16/5/15.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit

//button tab bar
class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(red:59.0/255.0,green:183.0/255.0,blue:99.0/255.0,alpha:1)
        self.addCenterButton(btnimage: UIImage(named: "button_add")!, selectedbtnimg: UIImage(named: "button_add")!, selector: "addOrderView", view: self.view)
        
    }
    
    //参数说明
    //btnimage 按钮图片
    //selectedbtnimg 点击时图片
    //selector 按钮方法名称
    //view 按钮添加到view  正常是 self.view就可以
    func addCenterButton(btnimage buttonImage:UIImage,selectedbtnimg selectedimg:UIImage,selector:String,view:UIView)
    {
        //创建一个自定义按钮
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        //btn.autoresizingMask
        //button大小为适应图片
        button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        button.setImage(buttonImage, forState: UIControlState.Normal)
        button.setImage(selectedimg, forState: UIControlState.Selected)
        //去掉阴影
        button.adjustsImageWhenDisabled = true;
        //按钮的代理方法
        button.addTarget( self, action: Selector(selector), forControlEvents:UIControlEvents.TouchUpInside )
        //高度差
        let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if (heightDifference < 0){
            button.center = self.tabBar.center;
        }
        else
        {
            var center:CGPoint = self.tabBar.center;
            center.y = center.y - heightDifference/2.0;
            button.center = center;
        }
        view.addSubview(button);
    }
    
    
    //按钮方法
    func addOrderView()
    {
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("editNavigationController") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
}
