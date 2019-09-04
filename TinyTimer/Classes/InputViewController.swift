//
//  InputViewController.swift
//  TinyTimer
//
//  Created by Tri Ngoc Nguyen on 09/12/2015.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class InputViewController: NSViewController {
    var actionClose: (() -> Void)!
    var actionStart: ((_ seconds: Int) -> Void)!

    @IBOutlet weak var datePicker: NSDatePicker!

    @IBOutlet weak var btnStart: NSButton!
    var selectedSeconds : Int!
    
    //functions
//    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil.map { NSNib.Name(rawValue: $0) }, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.btnStart.keyEquivalent = "\r"
        
        //set to GB
        let locale = NSLocale(localeIdentifier: "en_GB")
        self.datePicker.locale = locale as Locale
    }
    override func viewWillAppear() {
        //update data here
        super.viewWillAppear()
        //create time (hours, minutes, seconds) of today
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.hour, .minute, .second], from: NSDate() as Date)
        components.hour = 0
        components.minute = 0
        components.second = self.selectedSeconds
        self.datePicker.dateValue = calendar.date(from: components)!
    }
    override func viewDidAppear() {
        self.datePicker.becomeFirstResponder()
    }
    @IBAction func handleCancelTouched(sender: AnyObject) {
        //close nspopover
        if (self.actionClose != nil) {
            self.actionClose()
        }
    }
    
    @IBAction func handleStartTouched(sender: AnyObject) {
        doFinish()
    }
    @IBAction func handleDatePickerAction(sender: AnyObject) {
        self.btnStart.becomeFirstResponder()
    }
    func doFinish() {
        //start timer
        self.datePicker.resignFirstResponder()
        let components = NSCalendar.current.dateComponents([.hour, .minute, .second], from: self.datePicker.dateValue)
        let hours = components.hour
        let minutes = components.minute
        let seconds = components.second
        let totalSeconds = hours! * 3600 + minutes! * 60 + seconds!
        print(self.datePicker.dateValue)
        print(totalSeconds)
        if (self.actionStart != nil)    {
            self.actionStart(totalSeconds)
        }
    }
}
