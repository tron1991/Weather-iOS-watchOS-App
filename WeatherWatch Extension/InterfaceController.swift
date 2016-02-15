//
//  InterfaceController.swift
//  WeatherWatch Extension
//
//  Created by Nick on 2016-02-12.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var weatherPic: WKInterfaceImage!
    @IBOutlet var weatherDay: WKInterfaceLabel!
    @IBOutlet var weatherDesc: WKInterfaceLabel!
    @IBOutlet var weathertemp: WKInterfaceLabel!
    
    var session: WCSession!
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func refreshWeather() {
        let messageToSend = ["Temp":"0"]
        
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
                let temp = replyMessage["Temp"] as? String
                    self.weathertemp.setText(temp! + "°C")
                let pic = replyMessage["Pic"] as? String
                    self.weatherPic.setImageNamed(pic)
                let day = replyMessage["Day"] as? String
                    self.weatherDay.setText(day)
                let desc = replyMessage["Desc"] as? String
                    self.weatherDesc.setText(desc)
            }
            , errorHandler: {error in
                // catch any errors here
                print(error)
        })
        

}
//        //Swift
//    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
//        
//        let value = message["Temp"] as? String
//        
//        dispatch_async(dispatch_get_main_queue()) {
//            self.weathertemp.setText(value)
//        }
//        
//        //send a reply
//        replyHandler(["Value":"Yes"])
//        
//    }


}
