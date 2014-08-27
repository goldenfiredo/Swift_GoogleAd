//
//  ViewController.swift
//  GoogleAd
//
//  Created by Limin Du on 8/27/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GADBannerViewDelegate {
    var bannerView:GADBannerView?
    var timer:NSTimer?
    var loadRequestAllowed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerView = GADBannerView()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView?.adUnitID = "ca-app-pub-6938332798224330/5303633206"
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        self.view.addSubview(bannerView!)
        bannerView?.loadRequest(GADRequest())
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(40, target: self, selector: "GoogleAdRequestTimer", userInfo: nil, repeats: true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AppBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AppResignActive", name: UIApplicationWillResignActiveNotification, object: nil)
    }

    func GoogleAdRequestTimer() {
        if (!loadRequestAllowed) {
            println("load request not allowed")
            return
        }
        
        println("load request")
        bannerView?.loadRequest(GADRequest())
    }
    
    func AppBecomeActive() {
        println("received UIApplicationDidBecomeActiveNotification")
        loadRequestAllowed = true
    }
    
    func AppResignActive() {
        println("received UIApplicationWillResignActiveNotification")
        loadRequestAllowed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("adViewDidReceiveAd:\(view)");
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
    }
    
    
}

