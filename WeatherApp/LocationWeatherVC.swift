//
//  LocationWeatherVC.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit

class LocationWeatherVC: UIViewController {
    
    @IBOutlet weak var locationInputBox: UITextField!
    
    var weather : Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       weather = Weather(location: locationInputBox.text!)
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
      performSegueWithIdentifier("MainWeatherVC", sender: nil)
    }
    
    
    
}
    


