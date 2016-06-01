//
//  AddEntryViewController.swift
//  SwiftFMDBDemo
//
//  Created by Limin Du on 11/18/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import Foundation
import UIKit

class AddEntryViewController : UIViewController, UITextFieldDelegate {
    var nameLabel:UILabel?
    var descLabel:UILabel?
    var nameTextField:UITextField?
    var descTextField:UITextField?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(AddEntryViewController.saveEntry))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        nameLabel = UILabel(frame: CGRectMake(20, 80, 300, 30))
        nameLabel?.font = UIFont.boldSystemFontOfSize(12)
        nameLabel?.text = "Entry name:"
        self.view.addSubview(nameLabel!)
        
        nameTextField = UITextField(frame: CGRectMake(30, 110, 260, 30))
        nameTextField?.backgroundColor = UIColor .grayColor()
        nameTextField!.becomeFirstResponder()
        nameTextField!.keyboardType = .Default
        nameTextField!.returnKeyType = .Done
        nameTextField!.addTarget(self, action: #selector(AddEntryViewController.textFieldDone(_:)), forControlEvents: .EditingDidEndOnExit)
        nameTextField!.tag = 1
        nameTextField!.placeholder = "the name can't be empty"
        self.view.addSubview(nameTextField!)
        
        descLabel = UILabel(frame: CGRectMake(20, 150, 300, 30))
        descLabel?.font = UIFont.boldSystemFontOfSize(12)
        descLabel?.text = "Entry description:"
        self.view.addSubview(descLabel!)
        
        descTextField = UITextField(frame: CGRectMake(30, 180, 260, 30))
        descTextField?.backgroundColor = UIColor.grayColor()
        descTextField!.keyboardType = .Default
        descTextField!.returnKeyType = .Done
        descTextField!.addTarget(self, action: #selector(AddEntryViewController.textFieldDone(_:)), forControlEvents: .EditingDidEndOnExit)
        descTextField!.tag = 2
        self.view.addSubview(descTextField!)
    }
    
    func saveEntry() {
        let name = nameTextField!.text!
        let desc = descTextField!.text!
        print("in save entry. name:\(name), description:\(desc)")
        
        if !name.isEmpty {
            let dal = EntryDAL()
            let entry1 = Entry()
            entry1.name = name
            entry1.description = desc
            dal.insertEntry(entry1)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            NSNotificationCenter.defaultCenter().postNotificationName("kDisplayInterstitialNotification", object: nil)
        }
    }
    
    func textFieldDone(sender:UITextField) {
        if sender.tag == 1 {
            descTextField?.becomeFirstResponder()
        } else {
            nameTextField?.becomeFirstResponder()
        }
    }
}