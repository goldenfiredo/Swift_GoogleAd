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
    
    let dal = EntryDAL()
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
        
        rowData = dal.getAllEntries()
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
        println("didSelectRowAtIndex")
        
        let data = rowData[rowIndex]
        
        pushControllerWithName("DetailEntry", context: data)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        NSLog("%@ didDeactivate", self)
    }

    @IBAction func refresh() {
        println("refresh tapped")
        
        rowData = dal.getAllEntries()
        load()
    }
}
