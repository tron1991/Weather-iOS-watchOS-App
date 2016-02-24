//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit
import WatchConnectivity
import Spring

class MainWeatherVC: UIViewController, WCSessionDelegate {
    
   
    @IBOutlet weak var dayOfTheWeekLabel: SpringLabel!
    @IBOutlet weak var dateOfTheWeekLabel: SpringLabel!
    @IBOutlet weak var weatherPictureImg: SpringImageView!
    @IBOutlet weak var dayTempLabel: SpringLabel!
    @IBOutlet weak var dayDescription: SpringLabel!
    
    
    //5 Day Forcast TODO: tableView for data inputs
    @IBOutlet weak var dayOneDate: SpringLabel!
    @IBOutlet weak var dayTwoDate: SpringLabel!
    @IBOutlet weak var dayThreeDate: SpringLabel!
    @IBOutlet weak var dayFourDate: SpringLabel!
    @IBOutlet weak var dayFiveDate: SpringLabel!
    
    @IBOutlet weak var dayOnePic: SpringImageView!
    @IBOutlet weak var dayTwoPic: SpringImageView!
    @IBOutlet weak var dayThreePic: SpringImageView!
    @IBOutlet weak var dayFourPic: SpringImageView!
    @IBOutlet weak var dayFivePic: SpringImageView!
    
    @IBOutlet weak var dayOneDesc: SpringLabel!
    @IBOutlet weak var dayTwoDesc: SpringLabel!
    @IBOutlet weak var dayThreeDesc: SpringLabel!
    @IBOutlet weak var dayFourDesc: SpringLabel!
    @IBOutlet weak var dayFiveDesc: SpringLabel!
    
    @IBOutlet weak var dayOneTemp: SpringLabel!
    @IBOutlet weak var dayTwoTemp: SpringLabel!
    @IBOutlet weak var dayThreeTemp: SpringLabel!
    @IBOutlet weak var dayFourTemp: SpringLabel!
    @IBOutlet weak var dayFiveTemp: SpringLabel!
    
    var manager: OneShotLocationManager?
    var weatherToday : Weather!
    var weatherFiveDay: Weather!
    var saveLat: Double!
    var saveLong: Double!
    
    var session: WCSession!
    
    //MARK -LifeCycle of the App
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()
        }
        
        locationUpdate()
    }
    
    func locationUpdate() {
        // request the current location
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                
                self.saveLat = loc.coordinate.latitude
                self.saveLong = loc.coordinate.longitude
                let weatherType = true
                self.weatherToday = Weather(locationLat: self.saveLat, locationLong: self.saveLong, apiCall: weatherType)
                self.weatherToday.downloadWeatherDetails { () -> () in
                    self.updateMainUI()
                }
                self.delay(0.5) {
                          let weatherT = false
                self.weatherFiveDay = Weather(locationLat: self.saveLat, locationLong: self.saveLong, apiCall: weatherT)
            
                self.weatherFiveDay.downloadFiveDayWeatherDetails{ () -> () in
                    self.updateFiveDayForecast()
                  }
                }
          
            } else if let err = error {
                print(err.localizedDescription.lowercaseString)
                //print("ccarroro")
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }

    }
    
    func updateMainUI() {
        self.weatherPictureImg.image = UIImage(named: setBigPic(weatherToday.todayWeatherPic))
        weatherPictureImg.animation = "squeezeLeft"
        weatherPictureImg.animate()
        
        self.dayTempLabel.text = weatherToday.todayTemp + "°C"
        dayTempLabel.animation = "squeezeRight"
        dayTempLabel.animate()
        
        self.dayDescription.text = weatherToday.todayDescription
        dayDescription.animation = "pop"
        dayDescription.animate()
        
        self.dayOfTheWeekLabel.text = weatherToday.day
        dayOfTheWeekLabel.animation = "slideDown"
        dayOfTheWeekLabel.animate()
        
        self.dateOfTheWeekLabel.text = weatherToday.date
        dateOfTheWeekLabel.animation = "slideDown"
        dateOfTheWeekLabel.animate()
    }
    
    func updateFiveDayForecast() {
        
        
        //animations 

        self.dayOneDate.text = weatherFiveDay.weath[0]
        dayOneDate.animation = "slideLeft"
        dayOneDate.animate()
        
        self.dayOnePic.image = UIImage(named: setPic(weatherFiveDay.weath[1]))
        dayOnePic.animation = "slideLeft"
        dayOnePic.animate()
        
        self.dayOneDesc.text = weatherFiveDay.weath[2]
        dayOneDesc.animation = "slideLeft"
        dayOneDesc.animate()
        
        self.dayOneTemp.text = weatherFiveDay.weath[3] + "°C"
        dayOneTemp.animation = "slideLeft"
        dayOneTemp.animate()
        
        
        
        
        self.dayTwoDate.text = weatherFiveDay.weath[4]
        dayTwoDate.animation = "slideRight"
        dayTwoDate.animate()
        
        self.dayTwoPic.image = UIImage(named: setPic(weatherFiveDay.weath[5]))
        dayTwoPic.animation = "slideRight"
        dayTwoPic.animate()
        
        self.dayTwoDesc.text = weatherFiveDay.weath[6]
        dayTwoDesc.animation = "slideRight"
        dayTwoDesc.animate()
        
        self.dayTwoTemp.text = weatherFiveDay.weath[7] + "°C"
        dayTwoTemp.animation = "slideRight"
        dayTwoTemp.animate()
        
        
        

        self.dayThreeDate.text = weatherFiveDay.weath[8]
        dayThreeDate.animation = "slideLeft"
        dayThreeDate.animate()
        
        self.dayThreePic.image = UIImage(named: setPic(weatherFiveDay.weath[9]))
        dayThreePic.animation = "slideLeft"
        dayThreePic.animate()
        
        self.dayThreeDesc.text = weatherFiveDay.weath[10]
        dayThreeDesc.animation = "slideLeft"
        dayThreeDesc.animate()
        
        self.dayThreeTemp.text = weatherFiveDay.weath[11] + "°C"
        dayThreeTemp.animation = "slideLeft"
        dayThreeTemp.animate()
        
        
        

        self.dayFourDate.text = weatherFiveDay.weath[12]
        dayFourDate.animation = "slideRight"
        dayFourDate.animate()
        
        self.dayFourPic.image = UIImage(named: setPic(weatherFiveDay.weath[13]))
        dayFourPic.animation = "slideRight"
        dayFourPic.animate()
        
        self.dayFourDesc.text = weatherFiveDay.weath[14]
        dayFourDesc.animation = "slideRight"
        dayFourDesc.animate()
        
        self.dayFourTemp.text = weatherFiveDay.weath[15] + "°C"
        dayFourTemp.animation = "slideRight"
        dayFourTemp.animate()
        

        self.dayFiveDate.text = weatherFiveDay.weath[16]
        dayFiveDate.animation = "slideLeft"
        dayFiveDate.animate()
        
        self.dayFivePic.image = UIImage(named: setPic(weatherFiveDay.weath[17]))
        dayFivePic.animation = "slideLeft"
        dayFivePic.animate()
        
        self.dayFiveDesc.text = weatherFiveDay.weath[18]
        dayFiveDesc.animation = "slideLeft"
        dayFiveDesc.animate()
        
        self.dayFiveTemp.text = weatherFiveDay.weath[19] + "°C"
        dayFiveTemp.animation = "slideLeft"
        dayFiveTemp.animate()
        
    }
    
    func setPic(weather: String) -> String {
        switch weather {
        case "Clouds":
            return "cloud_35"
        case "Rain":
            return "raindrops_35"
        case "Snow":
            return "snow_35"
        case "Clear":
            return "sun_35"
        default:
            return "sun_35"
        }
    }
    
    func setBigPic(weather: String) -> String {
        switch weather {
        case "Clouds":
            return "Clouds"
        case "Rain":
            return "Rain"
        case "Snow":
            return "Snow"
        case "Clear":
            return "Clear"
        default:
            return "Clear"
        }
    }

    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    
    
    //MARK: Refresh and Apple Watch Connectivity

    func refreshButtonTapped(sender: AnyObject) {
        refreshWeatherStats()
    }
    
    
    func refreshWeatherStats() {
        locationUpdate()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        let data : [String: AnyObject] = ["Temp": weatherToday.todayTemp, "Pic": weatherToday.todayWeatherPic, "Day": weatherToday.date, "Desc": weatherToday.todayDescription]
        replyHandler(data)
        
    }
    

}
