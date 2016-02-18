//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit
import WatchConnectivity

class MainWeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dateOfTheWeekLabel: UILabel!
    @IBOutlet weak var weatherPictureImg: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var dayDescription: UILabel!
    
    var manager: OneShotLocationManager?
    var weatherToday : Weather!
    
    var session: WCSession!
    
    //MARK -LifeCycle of the App
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        
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
                self.weatherToday = Weather(locationLat: loc.coordinate.latitude, locationLong: loc.coordinate.longitude)
                self.refreshWeatherStats()
     
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
    
    //MARK - Table View Delegates
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell", forIndexPath: indexPath) as? WeatherCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: Refresh and Apple Watch Connectivity

    @IBAction func refreshButtonTapped(sender: AnyObject) {
        refreshWeatherStats()
    }
    
    
    func refreshWeatherStats() {
        weatherToday.downloadWeatherDetails { () -> () in
            self.updateMainUI()
        }
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        let data : [String: AnyObject] = ["Temp": weatherToday.todayTemp, "Pic": weatherToday.todayWeatherPic, "Day": weatherToday.date, "Desc": weatherToday.todayDescription]
        replyHandler(data)
        
    }
    

}
