//
//  NotificationController.swift
//  GoogleAd
//
//  Created by Du Limin on 5/10/15.
//  Copyright (c) 2015 GoldenFire.Do. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var descLabel: WKInterfaceLabel!
    
    var rowData=[Entry]()
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
        rowData = EntryDAL().getAllEntries()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        
        //For demo purpose, I only display first entry on notification's UI
        if rowData.count > 0 {
            let rd = rowData[0];
            nameLabel.setText(rd.name)
            descLabel.setText(rd.description)
        }
        
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    
    /*
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
}
