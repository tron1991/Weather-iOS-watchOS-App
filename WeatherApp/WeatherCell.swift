//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
//    @IBOutlet weak var fiveWeekDay: UILabel!
//    @IBOutlet weak var fiveDateImage: UIImageView!
//    @IBOutlet weak var fiveDateDescription: UILabel!
//    @IBOutlet weak var fiveDateTemperature: UILabel!
//    
    var weather: Weather!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func configureCell(weather: Weather) {
        self.weather = weather
    
//        fiveWeekDay.text = self.weather.weatherFiveDay
//        fiveDateImage.image = UIImage(named: "\(self.weather.weatherFivePic)")
//        fiveDateDescription.text = self.weather.weatherFiveDescription.capitalizedString
//        fiveDateTemperature.text = self.weather.weatherFiveTemp + "°C"
//        
//        for var x = 0; x <= 4; x++ {
//            fiveWeekDay.text = self.weather.weath[x+1]
//            fiveDateImage.image = UIImage(named: "\(self.weather.weath[x+1])")
//            fiveDateDescription.text = self.weather.weath[x+1]
//            fiveDateTemperature.text = self.weather.weath[x+1] + "°C"
//        }
//        
        
    }
    
//    func fakeCell() {
//        self.fiveWeekDay.text = "Friday"
//        self.fiveDateImage.image = UIImage(named: "snow_35")
//        self.fiveDateDescription.text = "Snowy and Cold"
//        self.fiveDateTemperature.text = "12°C"
//    }
//    

}
