//
//  FMDBDemoViewController.swift
//  SwiftFMDBDemo
//
//  Created by Limin Du on 11/18/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class FMDBDemoViewController : UITableViewController, GADInterstitialDelegate {
    let dal = EntryDAL()
    var data=[Entry]()
    
    var interstitial:GADInterstitial?
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(FMDBDemoViewController.addEntry))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        interstitial = createAndLoadInterstitial()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FMDBDemoViewController.displayInterstitial), name: "kDisplayInterstitialNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FMDBDemoViewController.refresh), name: "kRefreshFMDBNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        data = dal.getAllEntries()
    
        self.tableView.reloadData()
    }
    
    func addEntry() {
        print("in add Entry")
        
        let addVC = AddEntryViewController()
        let navVC = UINavigationController(rootViewController: addVC)
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(FMDBDemoViewController.back))
        //backButton.tintColor = UIColor.redColor()
        addVC.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = data[index].name
        cell.detailTextLabel?.text = data[index].description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let e = data[indexPath.row]
        if dal.deleteEntry(e) {
            data.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //Interstitial func
    func createAndLoadInterstitial()->GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-6938332798224330/6206234808")
        interstitial.delegate = self
        interstitial.loadRequest(GADRequest())
        
        return interstitial
    }
    
    //Interstitial delegate
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("interstitialDidFailToReceiveAdWithError:\(error.localizedDescription)")
        interstitial = createAndLoadInterstitial()
    }
    
    func interstitialWillDismissScreen(ad: GADInterstitial!) {
        interstitial = createAndLoadInterstitial()
    }
    
    /*func interstitialDidDismissScreen(ad: GADInterstitial!) {
        println("interstitialDidDismissScreen")
    }
    
    func interstitialWillLeaveApplication(ad: GADInterstitial!) {
        println("interstitialWillLeaveApplication")
    }
    
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        println("interstitialWillPresentScreen")
    }*/
    
    func displayInterstitial() {
        if (interstitial?.isReady) != nil {
            interstitial?.presentFromRootViewController(self)
        }
    }
    
    func refresh() {
        print("in refresh")
        
        data = dal.getAllEntries()
        self.tableView.reloadData()
    }
}