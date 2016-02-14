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
    
    private var _todayDate: String!
    private var _todayWeatherPic: String!
    private var _todayTemp: Double!
    private var _todayDescription: String!
    private var _fiveDayWeatherPic: String!
    private var _fiveDayDate: String!
    private var _fiveDayDescription: String!
    private var _fiveDayTemp: String!
    private var _weatherUrl: String!
    private var _weatherLocation: String!
    
    
    
    var todayDate : String {
        get {
            if _todayDate == nil {
            _todayDate = ""
        }
        return _todayDate
        }
    }
    
    var todayWeatherPic: String {
        get {
        if _todayWeatherPic == nil {
            _todayWeatherPic = ""
        }
        return _todayWeatherPic
        }
    }
    
    var todayTemp: Double {
        get {
        if _todayTemp == nil {
            _todayTemp = 0.0
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
    
    var fiveDayWeatherPic: String {
        get {
        if _fiveDayWeatherPic == nil {
            _fiveDayWeatherPic = ""
        }
        return _fiveDayWeatherPic
        }
    }
    
    var fiveDayDate: String {
        get {
        if _fiveDayDate == nil {
            _fiveDayDate = ""
        }
        return _fiveDayDate
        }
    }
    
    var fiveDayDescription: String {
        get {
        if _fiveDayDescription == nil {
            _fiveDayDescription = ""
        }
        return _fiveDayDescription
        }
    }
    
    var fiveDayTemp: String {
        get {
        if _fiveDayTemp == nil {
            _fiveDayTemp = ""
        }
        return _fiveDayTemp
        }
      
    }
    
    var weatherLocation: String {
        get {
        if _weatherLocation == nil {
            _weatherLocation = ""
        }
        return _weatherLocation
        }
    }
    
    init(location: String) {
        self._weatherLocation = "London"
        _weatherUrl = "\(URL_BASE)\(URL_WEATHER)\(self._weatherLocation)\(URL_OWEATHER_API_KEY)"
        
    }
    
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
                } else {
                    self._todayDescription = ""
                    self._todayWeatherPic = ""
                }
                
                if let wTemp = dict["main"] as? [Dictionary<String, AnyObject>] where wTemp.count > 0 {
                    
                    if let temp = wTemp[0]["temp"] as? Double {
                        self._todayTemp = temp
                    }
                } else {
                    self._todayTemp = 0.0
                }
            }
            
            completed()
            
        }
        
        
        
    }
    
    
    
}
