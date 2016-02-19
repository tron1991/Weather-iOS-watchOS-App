//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit
import WatchConnectivity

class MainWeatherVC: UIViewController, WCSessionDelegate {
    
   
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dateOfTheWeekLabel: UILabel!
    @IBOutlet weak var weatherPictureImg: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var dayDescription: UILabel!
    
    
    //5 Day Forcast TODO: tableView for data inputs
    @IBOutlet weak var dayOneDate: UILabel!
    @IBOutlet weak var dayTwoDate: UILabel!
    @IBOutlet weak var dayThreeDate: UILabel!
    @IBOutlet weak var dayFourDate: UILabel!
    @IBOutlet weak var dayFiveDate: UILabel!
    
    
    @IBOutlet weak var dayOnePic: UIImageView!
    @IBOutlet weak var dayTwoPic: UIImageView!
    @IBOutlet weak var dayThreePic: UIImageView!
    @IBOutlet weak var dayFourPic: UIImageView!
    @IBOutlet weak var dayFivePic: UIImageView!
    
    @IBOutlet weak var dayOneDesc: UILabel!
    @IBOutlet weak var dayTwoDesc: UILabel!
    @IBOutlet weak var dayThreeDesc: UILabel!
    @IBOutlet weak var dayFourDesc: UILabel!
    @IBOutlet weak var dayFiveDesc: UILabel!
    
    @IBOutlet weak var dayOneTemp: UILabel!
    @IBOutlet weak var dayTwoTemp: UILabel!
    @IBOutlet weak var dayThreeTemp: UILabel!
    @IBOutlet weak var dayFourTemp: UILabel!
    @IBOutlet weak var dayFiveTemp: UILabel!
    
    var manager: OneShotLocationManager?
    var weatherToday : Weather!
    var weatherFiveDay: Weather!
    
    var session: WCSession!
    
    //MARK -LifeCycle of the App
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()
        }
        // request the current location
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                
                let weatherType = true
                self.weatherToday = Weather(locationLat: loc.coordinate.latitude, locationLong: loc.coordinate.longitude, apiCall: weatherType)
                self.weatherToday.downloadWeatherDetails { () -> () in
                    self.updateMainUI()
                }
                
                let weatherT = false
                self.weatherFiveDay = Weather(locationLat: loc.coordinate.latitude, locationLong: loc.coordinate.longitude, apiCall: weatherT)
                self.weatherFiveDay.downloadFiveDayWeatherDetails{ () -> () in
                    self.updateFiveDayForecast()
                }
                
            } else if let err = error {
                print(err.localizedDescription)
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
    }
    
    func updateMainUI() {
        self.weatherPictureImg.image = UIImage(named: weatherToday.todayWeatherPic)
        self.dayTempLabel.text = weatherToday.todayTemp + "°C"
        self.dayDescription.text = weatherToday.todayDescription
        self.dayOfTheWeekLabel.text = weatherToday.day
        self.dateOfTheWeekLabel.text = weatherToday.date
    }
    
    func updateFiveDayForecast() {
        self.dayOneDate.text = weatherFiveDay.weath[0]
        self.dayOnePic.image = UIImage(named: setPic(weatherFiveDay.weath[1]))
        self.dayOneDesc.text = weatherFiveDay.weath[2]
        self.dayOneTemp.text = weatherFiveDay.weath[3] + "°C"
        
        self.dayTwoDate.text = weatherFiveDay.weath[4]
        self.dayTwoPic.image = UIImage(named: setPic(weatherFiveDay.weath[5]))
        self.dayTwoDesc.text = weatherFiveDay.weath[6]
        self.dayTwoTemp.text = weatherFiveDay.weath[7] + "°C"

        self.dayThreeDate.text = weatherFiveDay.weath[8]
        self.dayThreePic.image = UIImage(named: setPic(weatherFiveDay.weath[9]))
        self.dayThreeDesc.text = weatherFiveDay.weath[10]
        self.dayThreeTemp.text = weatherFiveDay.weath[11] + "°C"

        self.dayFourDate.text = weatherFiveDay.weath[12]
        self.dayFourPic.image = UIImage(named: setPic(weatherFiveDay.weath[13]))
        self.dayFourDesc.text = weatherFiveDay.weath[14]
        self.dayFourTemp.text = weatherFiveDay.weath[15] + "°C"

        self.dayFiveDate.text = weatherFiveDay.weath[16]
        self.dayFivePic.image = UIImage(named: setPic(weatherFiveDay.weath[17]))
        self.dayFiveDesc.text = weatherFiveDay.weath[18]
        self.dayFiveTemp.text = weatherFiveDay.weath[19] + "°C"
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

    
    
    //MARK: Refresh and Apple Watch Connectivity

    @IBAction func refreshButtonTapped(sender: AnyObject) {
        refreshWeatherStats()
    }
    
    
    func refreshWeatherStats() {
        weatherToday.downloadWeatherDetails { () -> () in
            self.updateMainUI()
        }
        
        self.weatherFiveDay.downloadFiveDayWeatherDetails{ () -> () in
            self.updateFiveDayForecast()
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        let data : [String: AnyObject] = ["Temp": weatherToday.todayTemp, "Pic": weatherToday.todayWeatherPic, "Day": weatherToday.date, "Desc": weatherToday.todayDescription]
        replyHandler(data)
        
    }
    

}
