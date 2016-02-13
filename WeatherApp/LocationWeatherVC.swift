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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MainWeather" {
            if let mainWeather = segue.destinationViewController as? MainWeatherVC {
                if let weather = sender as? Weather {
                    mainWeather.weatherDay = weather
                    mainWeather.weatherFive = weather
                }
            }
            
        }
    }
    

}
