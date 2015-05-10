//
//  GlanceController.swift
//  GoogleAd
//
//  Created by Du Limin on 5/10/15.
//  Copyright (c) 2015 GoldenFire.Do. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var descLabel: WKInterfaceLabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var rowData=[Entry]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        rowData = EntryDAL().getAllEntries()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if let selectedEntry = defaults.stringForKey("selectedEntry") {
            for ent in rowData {
                if ent.name == selectedEntry {
                    nameLabel.setText(ent.name)
                    descLabel.setText(ent.description)
                    
                    updateUserActivity("com.ereda.GoogleAd.glance", userInfo: ["entry": ent.name], webpageURL: nil)
                    
                    break
                }
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
