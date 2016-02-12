//
//  Weather.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import Foundation

class Weather {
    
    private var _todayDate: String!
    private var _todayWeatherPic: String!
    private var _todayTemp: String!
    private var _todayDescription: String!
    private var _fiveDayWeatherPic: String!
    private var _fiveDayDate: String!
    private var _fiveDayDescription: String!
    private var _fiveDayTemp: String!
    
    var todayDate : String {
        return _todayDate
    }
    
    var todayWeatherPic: String {
        return _todayWeatherPic
    }
    
    var todayTemp: String {
        return _todayTemp
    }

    var todayDescription: String {
        return _todayDescription
    }
    
    var fiveDayWeatherPic: String {
        return _fiveDayWeatherPic
    }
    
    var fiveDayDate: String {
        return _fiveDayDate
    }
    
    var fiveDayDescription: String {
        return _fiveDayDescription
    }
    
    var fiveDayTemp: String {
        return _fiveDayTemp
      
    }
    
    init(todayDate: String, todayTemp: String, todayDescription: String) {
        self._todayDate = todayDate
        self._todayTemp = todayTemp
        self._todayDescription = todayDescription
    }
    
    
    
}
