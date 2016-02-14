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
    private var _todayTemp: String!
    private var _todayDescription: String!
    private var _fiveDayWeatherPic: String!
    private var _fiveDayDate: String!
    private var _fiveDayDescription: String!
    private var _fiveDayTemp: String!
    private var _weatherUrl: String!
    private var _weatherLocationLat: Double!
    private var _weatherLocationLong: Double!
    
    
    
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
        self._weatherLocationLong = 0.0
        self._weatherLocationLat = 0.0
        _weatherUrl = "\(URL_BASE)\(URL_WEATHER_LAT)\(self._weatherLocationLat)\(URL_WEATHER_LONG)\(self._weatherLocationLong)\(URL_OWEATHER_API_KEY)"
        
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: self._weatherUrl)!
       
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            print(result.error?.description)
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
                    
                    if let temp = wTemp[0]["temp"] as? String {
                        self._todayTemp = temp
                    }
                } else {
                    self._todayTemp = ""
                }
            }
            
            completed()
            
        }
        
        
        
    }
    
    
    
}
