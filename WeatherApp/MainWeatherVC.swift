//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Nick on 2016-02-11.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit

class MainWeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dateOfTheWeekLabel: UILabel!
    @IBOutlet weak var weatherPictureImg: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var dayDescription: UILabel!
    
     var manager: OneShotLocationManager?
    
    var weatherToday : Weather!
    
    //MARK -LifeCycle of the App
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        
        
        //
        // request the current location
        //
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                self.weatherToday = Weather(locationLat: loc.coordinate.latitude, locationLong: loc.coordinate.longitude)
                print(loc.coordinate.latitude)
            } else if let err = error {
                print(err.localizedDescription)
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
        
//        weatherToday.downloadWeatherDetails { () -> () in
//            
//            self.updateMainUI()
//        }
        
        
    }
    
    func updateMainUI() {
        self.weatherPictureImg.image = UIImage(named: weatherToday.todayWeatherPic)
        print(weatherToday.todayTemp)
        self.dayTempLabel.text = weatherToday.todayTemp
        self.dayDescription.text = weatherToday.todayDescription
    }
    
    //MARK - Table View Delegates
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell", forIndexPath: indexPath) as? WeatherCell {
            //cell.configureCell(weatherFive)
            cell.fakeCell()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        refreshWeatherStats()
    }
    
    
    func refreshWeatherStats() {
        weatherToday.downloadWeatherDetails { () -> () in
            self.updateMainUI()
        }
    }
}
