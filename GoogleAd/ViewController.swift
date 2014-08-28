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
    var imageView:UIImageView?
    var timer:NSTimer?
    var loadRequestAllowed = true
    var bannerDisplayed = false
    let statusbarHeight:CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerDisplayed = false
        bannerView = GADBannerView()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView?.adUnitID = "ca-app-pub-6938332798224330/9023870805"
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        self.view.addSubview(bannerView!)
        bannerView?.loadRequest(GADRequest())
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(40, target: self, selector: "GoogleAdRequestTimer", userInfo: nil, repeats: true)
        
        var image = UIImage(named: "admob.png")
        imageView = UIImageView(image: image)
        var frame = imageView!.frame
        frame.origin.x = 0
        frame.origin.y = statusbarHeight
        imageView!.frame = frame
        self.view.addSubview(imageView!)
        
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
        bannerDisplayed = true
        relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func relayoutViews() {
        if (bannerDisplayed) {
            var bannerFrame = bannerView!.frame
            bannerFrame.origin.x = 0
            bannerFrame.origin.y = statusbarHeight
            bannerView!.frame = bannerFrame
            
            var imageviewFrame = imageView!.frame
            imageviewFrame.origin.x = 0
            imageviewFrame.origin.y = statusbarHeight + bannerFrame.size.height
            imageView!.frame = imageviewFrame
        } else {
            var bannerFrame = bannerView!.frame
            bannerFrame.origin.x = 0
            bannerFrame.origin.y = 0 - bannerFrame.size.height
            bannerView!.frame = bannerFrame
            
            var imageviewFrame = imageView!.frame
            imageviewFrame.origin.x = 0
            imageviewFrame.origin.y = statusbarHeight
            imageView!.frame = imageviewFrame
        }
    }
    
}

