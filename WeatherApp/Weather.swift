//
//  Weather.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _todayWeatherPic: String!
    private var _todayTemp: String!
    private var _todayDescription: String!
    private var _weatherUrl: String!
    private var _weatherLocationLat: Double!
    private var _weatherLocationLong: Double!
    
    private var _day: String!
    private var _date: String!
    private var _time: String!
    
    
    var todayWeatherPic: String {
        get {
        if _todayWeatherPic == nil {
            _todayWeatherPic = ""
        }
        return _todayWeatherPic
        }
    }
    
    var todayTemp: String {
        get {
        if _todayTemp == nil {
            _todayTemp = ""
        }
        return _todayTemp
        }
    }

    var todayDescription: String {
        get {
        if _todayDescription == nil {
            _todayDescription = ""
        }
        return _todayDescription
        }
    }
    
    var day: String {
        get {
            if _day == nil {
                _day = ""
            }
            return _day
        }
    }
    
    var date: String {
        get {
            if _date == nil {
                _date = ""
            }
            return _date
        }
    }
    
    var time: String {
        get {
            if _time == nil {
                _time = ""
            }
            return _time
        }
    }
    
    var weatherLocationLat: Double {
        get {
        if _weatherLocationLat == nil {
            _weatherLocationLat = 0.0
        }
        return _weatherLocationLat
        }
    }
    
    var weatherLocationLong: Double {
        get {
            if _weatherLocationLong == nil {
                _weatherLocationLong = 0.0
            }
            return _weatherLocationLong
        }
    }
    
    init(locationLat: Double, locationLong: Double) {
        self._weatherLocationLong = locationLong
        self._weatherLocationLat = locationLat
        _weatherUrl = "\(URL_BASE)\(URL_WEATHER_LAT)\(self._weatherLocationLat)\(URL_WEATHER_LONG)\(self._weatherLocationLong)\(URL_OWEATHER_API_KEY)"
        
    }
    
    
//    func setImageForWeather(weatherImage: String) -> String {
//        
//        switch weatherImage {
//        case "Rain":
//            return "Rain"
//        case "Snow":
//            return "Snow"
//        case "Clear":
//            return "Clear"
//        case "Clouds":
//            return "Clouds"
//        case "Mist":
//            return "Mist"
//        default:
//            return "Start"
//        }
//        
//    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: self._weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let wDesc = dict["weather"] as? [Dictionary<String, AnyObject>] where wDesc.count > 0 {
                    
                    //get the weather description
                    if let weatherD = wDesc[0]["description"] as? String {
                           self._todayDescription = weatherD
                        
                    }
                    
                    //get the weather main pic name
                    if let wPic = wDesc[0]["main"] as? String {
                            self._todayWeatherPic = wPic
                    }
                }
                
                
                if let dt = dict["dt"] as? Double {
                    let date = NSDate(timeIntervalSince1970: dt)
                    let dayFormatter = NSDateFormatter()
                    let dateFormatter = NSDateFormatter()
                    let timeFormatter = NSDateFormatter()
                    dayFormatter.dateFormat = "EEEE"
                    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
                    timeFormatter.dateFormat = "h:mm a"
                    self._day = dayFormatter.stringFromDate(date)
                    self._date = dateFormatter.stringFromDate(date)
                    self._time = timeFormatter.stringFromDate(date)
                    print(self._day)
                    print(self._date)
                    print(self._time)
                    
                }

                
                if let wTemp = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let temp = wTemp["temp"] as? Double {
                        self._todayTemp = NSString(format: "%.0f", temp-273.15) as String
                    }
                }
            }
            
            completed()
            
        }
        
        
        
    }
    
    
    
}
