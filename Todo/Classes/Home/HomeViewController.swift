//
//  HomeViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/16.
//  Copyright © 2016年 Tammy. All rights reserved.
//
//
//  HomeViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/15.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import Kingfisher
import UIKit

let URL = "http://192.168.191.1:8080/TODO/Register"


class HomeViewController: UIViewController,  UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var wholeScrollView: UIScrollView!
    
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view, typically from a nib.
        //image width
        let imageW:CGFloat = self.scrollView.frame.size.width;
        let imageH:CGFloat = self.scrollView.frame.size.height;
        let imageY:CGFloat = 0;
        let totalCount:NSInteger = 3;
        for index in 0..<totalCount{
            let imageView:UIImageView = UIImageView();
            let imageX:CGFloat = CGFloat(index) * imageW;
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            let name:String = String(format: "img_0%d", index+1);
            //print(name)
            imageView.image = UIImage(named: name);
            self.scrollView.showsHorizontalScrollIndicator = false;
            self.scrollView.addSubview(imageView);
            
            
        }
        let contentW:CGFloat = imageW * CGFloat(totalCount);
        self.scrollView.contentSize = CGSizeMake(contentW, 0);
        self.scrollView.pagingEnabled = true;
        self.scrollView.delegate = self
        self.pageControl.numberOfPages = totalCount
        self.addTimer()
        
        //collection view
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.dataSource=self
        
        //table view 
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func nextImage(sender:AnyObject!){
        var page:Int = self.pageControl.currentPage;
        //print(page)
        if(page == 2){
            page = 0;
        }else{
            page = page + 1
        }
        let x:CGFloat = CGFloat(page) * self.scrollView.frame.size.width;
        self.scrollView.contentOffset = CGPointMake(x, 0);
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW:CGFloat = scrollView.frame.size.width;
        let x:CGFloat = scrollView.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW);
        self.pageControl.currentPage = page;
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer();
    }
    
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer();
    }
    
    
    func addTimer(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector:#selector(HomeViewController.nextImage(_:)), userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes);
    }
    
    func removeTimer(){
        self.timer.invalidate();
    }
    
    //collection view
    let courses = [
        ["name":"Eating","pic":"icon_eating"],
        ["name":"Travel","pic":"icon_travel"],
        ["name":"Sports","pic":"icon_sport"],
        ["name":"Team","pic":"icon_team"],
        ["name":"Activity","pic":"icon_activity"],
        ["name":"Hang Out","pic":"icon_hangout"],
        ["name":"Interest","pic":"icon_interest"],
        ["name":"Other","pic":"icon_other"],
    ]
    
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return courses.count;
    }
    
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        // storyboard里设计的单元格
        let identify:String = "collectionCell"
        // 获取设计的单元格，不需要再动态添加界面元素
        let cell = (self.collectionView?.dequeueReusableCellWithReuseIdentifier(
            identify, forIndexPath: indexPath))! as UICollectionViewCell
        // 从界面查找到控件元素并设置属性
        let icon = cell.contentView.viewWithTag(101) as! UIImageView
        let icon_image:UIImage = UIImage(named: courses[indexPath.item]["pic"]!)!
//        print(icon_image.size.width)
//        print(icon_image.size.height)
        //icon.frame = CGRectMake(0, 0, 30, 40)
        icon.image = icon_image
        //icon.center = cell.center
        //icon.center.y = icon.center.y - 10
        let icon_name = cell.contentView.viewWithTag(102) as! UILabel
        icon_name.text = courses[indexPath.item]["name"]
        icon_name.textColor = UIColor(red: 130/255, green: 137/255, blue: 141/255, alpha: 1.0)
        //icon_name.center.x = cell.frame.size.width/2
        return cell
    }
    
    //具体点击的哪个cell
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        print("select")
        print(indexPath)
    }
    
    //var id:Int
    //var avatar:String//图片的地址，不联网的下为图片的名字
    //var timeStamp:Int64//时间戳
    //var todoTime: Int64//指定的时间
    //var content:String//内容
    //var userName:Int//作者的ID
    //var location:Int //地点的ID
    //var likeCount:Int //喜欢的数量
    //var commentCount:Int //评论的数量
    //var type: Int //类型的ID
    let status = [
        ["id":"123","avatar":"http://img5.duitang.com/uploads/item/201407/25/20140725213616_czuBT.thumb.224_0.jpeg","timeStamp":"2016-05-18 09:00","todoTime":"2016-05-19 09:00",
        "content":"I wannna go shopping on Sunday.","userName":"Lily","location":"Tokyo","likeCount":"18",
        "commentCount":"24","type":"Hang Out"],
        ["id":"123","avatar":"http://cdnq.duitang.com/uploads/item/201412/24/20141224102635_utkHA.jpeg","timeStamp":"2016-05-18 09:00","todoTime":"2016-05-19 09:00",
            "content":"I am going to play football.","userName":"Mike","location":"Tokyo","likeCount":"10",
            "commentCount":"9","type":"Sports"],
        ["id":"123","avatar":"http://v1.qzone.cc/avatar/201507/20/15/45/55aca72c7fcfc304.jpg%21200x200.jpg","timeStamp":"2016-05-18 09:00","todoTime":"2016-05-19 09:00",
            "content":"I hope to take part in a BBQ party","userName":"Candy","location":"Tokyo","likeCount":"5",
            "commentCount":"4","type":"Activity"],
        ["id":"123","avatar":"http://cdn.duitang.com/uploads/item/201407/25/20140725212818_VZduJ.thumb.224_0.jpeg","timeStamp":"2016-05-18 09:00","todoTime":"2016-05-19 09:00",
            "content":"I wanna find a friend to learn English together.","userName":"Tammy","location":"Tokyo","likeCount":"2",
            "commentCount":"3","type":"Interest"]
        ]
    
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return status.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // storyboard里设计的单元格
     
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tableCell")! as UITableViewCell
        let todo = status[indexPath.row]
        let avatar = cell.viewWithTag(101) as! UIImageView
        let name = cell.viewWithTag(102) as! UILabel
        let time = cell.viewWithTag(103) as! UILabel
        let type = cell.viewWithTag(104) as! UIButton
        let content = cell.viewWithTag(105) as! UILabel
        let likeCount = cell.viewWithTag(106) as! UILabel
        let commentCount = cell.viewWithTag(107) as! UILabel
        
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
        
        avatar.kf_setImageWithURL(NSURL(string: todo["avatar"]!)!, placeholderImage: UIImage(named: "davatar_default"))
        name.text = todo["userName"]
        time.text = todo["timeStamp"]
        type.setTitle(todo["type"], forState: UIControlState.Normal)
        content.text = todo["content"]
        likeCount.text = todo["likeCount"]
        commentCount.text = todo["commentCount"]
    
        
        return cell

    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("selected")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
