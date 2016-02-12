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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func showWeatherButtonTapped(sender: AnyObject) {
       performSegueWithIdentifier("MainWeather", sender: nil)
    }
    

}
