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
    private var _forecastUrl: String!
    private var _weatherLocationLat: Double!
    private var _weatherLocationLong: Double!
    private var _weatherArr = [Weather]()
    
    private var _weatherFiveDay: String!
    private var _weatherFiveTemp: String!
    private var _weatherFivePic: String!
    private var _weatherFiveDescription: String!
    
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
    
    var weatherFiveDay: String {
        get {
            if _weatherFiveDay == nil {
                _weatherFiveDay = ""
            }
            return _weatherFiveDay
        }
    }
    
    var weatherFiveTemp: String {
        get {
            if _weatherFiveTemp == nil {
                _weatherFiveTemp = ""
            }
            return _weatherFiveTemp
        }
    }
    
    var weatherFivePic: String {
        get {
            if _weatherFivePic == nil {
                _weatherFivePic = ""
            }
            return _weatherFivePic
        }
    }
    
    var weatherFiveDescription: String {
        get {
            if _weatherFiveDescription == nil {
                _weatherFiveDescription = ""
            }
            return _weatherFiveDescription
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
    
    init(fiveDay: String, fivePic: String, fiveDesc: String, fiveTemp: String) {
        self._weatherFiveDay = fiveDay
        self._weatherFivePic = fivePic
        self._weatherFiveTemp = fiveTemp
        self._weatherFiveDescription = fiveDesc
    }
    
    func downloadWeatherDetails(completed: DownloadComplete)
    {
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
    
    /*
                
    func downloadFiveDayWeatherDetails(completed: DownloadCompleteOne)
            
            {
               _forecastUrl = "\(URL_BASE)\(URL_FIVE_WEATHER)\(self._weatherLocationLat)\(URL_WEATHER_LONG)\(self._weatherLocationLong)\(URL_OWEATHER_API_KEY)"
                let url = NSURL(string: self._forecastUrl)!
                
                Alamofire.request(.GET, url).responseJSON { response in
                    let result = response.result
                    
                    
                    print(result)
                    
                    
                    if let dict = result.value as? Dictionary<String,AnyObject> {
                    
                        if let list = dict["list"] as? [Dictionary<String,AnyObject>] where list.count > 0 {
                            
                            //start foreloop here
                           // for var x = 0; x <= 4; x++ {
                            
                            if let time = list[0]["dt"] as? Double {
                                let date = NSDate(timeIntervalSince1970: time)
                                let dayFormatter = NSDateFormatter()
                                dayFormatter.dateFormat = "EEEE"
                                self._weatherFiveDay = dayFormatter.stringFromDate(date)
                            }
                            
                            if let pic = list[0]["main"] as? Dictionary<String,AnyObject> {
                                if let main = pic["temp"] as? Double {
                                    self._weatherFivePic = NSString(format: "%.0f", main-273.15) as String
                                }
                            }
                            
                            if let weather = list[0]["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                                if let main = weather[0]["main"] as? String {
                                    self._weatherFivePic = main
                                }
                                
                                if let desc = weather[0]["description"] as? String {
                                    self._weatherFiveDescription = desc
                                }
                            }
//                                let weatherOne = Weather(fiveDay: self._weatherFiveDay, fivePic: self._weatherFivePic, fiveDesc: self._weatherFiveDescription, fiveTemp: self._weatherFiveTemp)
//                                self._weatherArr.append(weatherOne)
// }

                            
                        }
                    }
                    
                       completed()
                }
                
            }

*/
    
    
    
}
