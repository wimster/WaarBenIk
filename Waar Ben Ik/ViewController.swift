//
//  ViewController.swift
//  Waar Ben Ik
//
//  Created by Wim Smit on 12/12/14.
//  Copyright (c) 2014 ITMOTION. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var streetName: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    
    var manager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation: CLLocation = locations[0] as CLLocation
        // streetName.text = "\(userLocation.coordinate.latitude)"
        course.text = "\(userLocation.course)"
        speed.text = "\(userLocation.speed * 1.609)"
        altitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{(placemarks, NSError) in
        
            if NSError != nil { println(NSError)}
            else    {
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
                self.streetName.text = "\(p.thoroughfare) " + "\(p.subThoroughfare)"
                self.city.text = p.locality
                self.country.text = p.country
                self.zip.text = p.postalCode
                

            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

