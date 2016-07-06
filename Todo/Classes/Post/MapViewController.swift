//
//  MapViewController.swift
//  Todo
//
//  Created by Tammy on 16/5/29.
//  Copyright © 2016年 Tammy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var todo : TodoModel?
    var currLocation : CLLocation!
    var delegate : SelectLocationDelegate!
    var type : String = String("eating")
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
        
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        //        locationManager.requestAlwaysAuthorization()
        //        if(ios8()){
        //            locationManager.requestAlwaysAuthorization()
        //        }
        //
        //        locationManager.startUpdatingLocation()
    }
    
    func ios8() -> Bool{
        return UIDevice.currentDevice().systemVersion == "8.1"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 6.0, *)
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("ok!")
        
        currLocation = locations.last! as CLLocation
        print(currLocation.coordinate.longitude)
        print(currLocation.coordinate.latitude)
        LonLatToCity()
    }
    
    @available(iOS 2.0, *)
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print(error)
    }
    
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        var p:CLPlacemark?
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
            if (error == nil) {//转换成功，解析获取到的各个信息
                if error != nil {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                let pm = placemarks! as [CLPlacemark]
                if (pm.count > 0){
                    p = placemarks![0] as? CLPlacemark
                    //var city: String = (p!.addressDictionary! as NSDictionary).valueForKey("City") as! String
                    var city: String = (p!.addressDictionary! as NSDictionary).valueForKey("City") as! String
                    let country: NSString = (p!.addressDictionary! as NSDictionary).valueForKey("Country") as! NSString
                    let CountryCode: NSString = (p!.addressDictionary! as NSDictionary).valueForKey("CountryCode") as! NSString
                    let FormattedAddressLines: NSString = (p!.addressDictionary! as NSDictionary).valueForKey("FormattedAddressLines")?.firstObject as! NSString
                    let Name: NSString = (p!.addressDictionary! as NSDictionary).valueForKey("Name") as! NSString
                    var State: String = (p!.addressDictionary! as NSDictionary).valueForKey("State") as! String
                    let SubLocality: NSString = (p!.addressDictionary! as NSDictionary).valueForKey("SubLocality") as! NSString
                    print(city)
                    print(country)
                    print(CountryCode)
                    print(FormattedAddressLines)
                    print(Name)
                    print(State)
                    print(SubLocality)
                    //self.label.text = "city"
                    self.label.text = city
                    self.label1.text = State
                    self.type = city+" "+State
                    
                }else{
                    print("No Placemarks!")
                }
                
                //去掉“市”和“省”字眼
                //city = city.stringByReplacingOccurrencesOfString("市", withString: "")
                //State = State.stringByReplacingOccurrencesOfString("省", withString: "")
                
                
                
                //                println(city)
                //            println(country)
                //            println(CountryCode)
                //            println(FormattedAddressLines)
                //            println(Name)
                //                println(State)
                //            println(SubLocality)
            }else {
                //转换失败
            }
            
        })
    }
    
    @IBAction func backlocation(sender: AnyObject){
        
        self.delegate!.selectLocation(type)
        todo?.title = type
        self.navigationController?.popViewControllerAnimated(true)
        
    }
}
