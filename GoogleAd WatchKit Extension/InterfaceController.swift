//
//  InterfaceController.swift
//  GoogleAd WatchKit Extension
//
//  Created by Du Limin on 4/17/15.
//  Copyright (c) 2015 GoldenFire.Do. All rights reserved.
//

import WatchKit
import Foundation

struct RowData {
    let name: String
    let description: String
}

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    /*let rowData :[RowData] = [
        RowData(name:"abc", description:"this is abc"),
        RowData(name:"def", description:"this is def"),
        RowData(name:"ghi", description:"this is ghi")
    ]*/
    
    var rowData=[Entry]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        NSLog("%@ awakeWithContext", self)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ willActivate", self)
        
        rowData = EntryDAL().getAllEntries()
        load()
    }
    
    func load() {
        table.setNumberOfRows(rowData.count, withRowType: "Row")
        
        for i in 0 ..< rowData.count {
            let rd = rowData[i]
            if let row = table.rowControllerAtIndex(i) as? RowController {
                row.name.setText(rd.name)
                row.desc.setText(rd.description)
            }
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        print("didSelectRowAtIndex")
        
        let data = rowData[rowIndex]
        
        pushControllerWithName("DetailEntry", context: data)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        NSLog("%@ didDeactivate", self)
    }

    @IBAction func refresh() {
        print("refresh tapped")
        
        rowData = EntryDAL().getAllEntries()
        load()
    }
    
    override func handleUserActivity(userInfo: [NSObject : AnyObject]!) {
        if let handedEntry = userInfo["entry"] as? String {
            for ent in rowData {
                if ent.name == handedEntry {
                    pushControllerWithName("DetailEntry", context: ent)
                    break
                }
            }
        }
    }
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
        var rd = EntryDAL().getAllEntries()
        if rd.count > 0 {
            pushControllerWithName("DetailEntry", context: rd[0])
        }
    }
}
