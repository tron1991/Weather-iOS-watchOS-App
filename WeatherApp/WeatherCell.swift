//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var fiveWeekDay: UILabel!
    @IBOutlet weak var fiveDateImage: UIImageView!
    @IBOutlet weak var fiveDateDescription: UILabel!
    @IBOutlet weak var fiveDateTemperature: UILabel!
    
    var weather: Weather!
    
    func configureCell(weather: Weather) {
        //self.weather = weather
        self.fiveWeekDay.text = weather.weatherFiveDay
        self.fiveDateImage.image = UIImage(named: "\(weather.weatherFivePic)")
        self.fiveDateDescription.text = weather.weatherFiveDescription
        self.fiveDateTemperature.text = weather.weatherFiveTemp
    }
    
    func fakeCell() {
        self.fiveWeekDay.text = "Friday"
        self.fiveDateImage.image = UIImage(named: "snow_35")
        self.fiveDateDescription.text = "Snowy and Cold"
        self.fiveDateTemperature.text = "12°C"
    }
    

}
