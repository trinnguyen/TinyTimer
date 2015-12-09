//
//  TimerController.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimerController: NSObject {
    var settings : Settings
    let statusItem : NSStatusItem
    var selectedSeconds : Int
    var timerRunner : TimerRunner?
    
    let startItem : NSMenuItem
    let pauseResumeItem : NSMenuItem
    let stopItem : NSMenuItem
    let customItem : NSMenuItem
    var lastPercent = Float(1);
    
    init(statusItem : NSStatusItem ) {
        
        self.statusItem = statusItem
        self.timerRunner = nil
        
        //default values
        self.settings = Settings()
        selectedSeconds = self.settings.getLatestItem(Builds.defaultTimers)

        //menu
        startItem = NSMenuItem(title: "Start", action: Selector("doStart:"), keyEquivalent: "")
        pauseResumeItem = NSMenuItem(title: "Pause", action: Selector("doPause:"), keyEquivalent: "")
        stopItem = NSMenuItem(title: "Stop", action: Selector("doStop:"), keyEquivalent: "")
        customItem = NSMenuItem(title: "Custom", action: Selector("doCustom:"), keyEquivalent: "")
        
        super.init()
        //init menu
        self.initMenuItems()
        
        //update menu
        self.updateMenu()
     
        //start runner
        self.timerRunner = TimerRunner(actionUpdateProgress: self.doUpdateProgress, actionFinished: self.doFinished, seconds: selectedSeconds)
        
        //update menu
        self.updateMenu()
    }
    func initMenuItems()
    {
        //Control Items

        
        //Suggested Time Items
        let t0Item = NSMenuItem(title: "30 minutes", action: Selector("doCustom0:"), keyEquivalent: "")
        let t1Item = NSMenuItem(title: "1 hour", action: Selector("doCustom1:"), keyEquivalent: "")
        let t2Item = NSMenuItem(title: "2 hours", action: Selector("doCustom2:"), keyEquivalent: "")
        let t3Item = NSMenuItem(title: "4 hours", action: Selector("doCustom3:"), keyEquivalent: "")
        
        //Preferences Items
//        let perferenceItem = NSMenuItem(title: "Preferences", action: Selector("doPreferences:"), keyEquivalent: "")
        let aboutItem = NSMenuItem(title: "About", action: Selector("doAbout:"), keyEquivalent: "")
        
        //Quit Items
        let quitItem = NSMenuItem(title: "Quit TinyTimer", action: Selector("doQuit:"), keyEquivalent: "")
        
        let menu = NSMenu()
        menu.autoenablesItems = false
        menu.addItem(startItem)
        menu.addItem(pauseResumeItem)
        menu.addItem(stopItem)
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(t0Item)
        menu.addItem(t1Item)
        menu.addItem(t2Item)
        menu.addItem(t3Item)
        menu.addItem(customItem)
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(aboutItem)
        menu.addItem(quitItem)
        statusItem.menu = menu
        
        for item in menu.itemArray {
            item.target = self
        }
    }
    
    //Menu action
    func doQuit(sender: AnyObject?) {
        NSApplication.sharedApplication().terminate(self)
    }
    func doCustom0(sender: AnyObject?)
    {
        doStartTimer(30 * 60)
    }
    func doCustom1(sender: AnyObject?)
    {
        doStartTimer(60 * 60)
    }
    func doCustom2(sender: AnyObject?)
    {
        doStartTimer(2 * 60 * 60)
    }
    func doCustom3(sender: AnyObject?)
    {
        doStartTimer(4 * 60 * 60)
    }
    func doCustom(sender: AnyObject?)
    {

    }
    func doAbout(sender: AnyObject?)
    {
        NSApplication.sharedApplication().orderFrontStandardAboutPanel(NSApplication.sharedApplication());
    }
    
    func doStart(sender: AnyObject?)
    {
        doStartTimer(self.selectedSeconds)
    }
    func doPause(sender: AnyObject?)
    {
        self.timerRunner?.togglePause()
        updateMenu()
    }
    func doStop(sender: AnyObject?)
    {
        self.timerRunner?.stop()
        updateMenu()
    }
    
    //Timmer Runner callbacks
    func doUpdateProgress(progress : String, percent : Float, force : Bool)
    {
        if (force || (self.lastPercent - percent >= 0.027 || self.statusItem.button?.image == nil || self.timerRunner?.getStatus() != TimerStatus.Running))
        {
            var color = Builds.normalColor
            if (self.timerRunner?.getStatus() == TimerStatus.Running)
            {
                color = Builds.highlightColor
            }
            self.lastPercent = percent
            self.statusItem.button?.image = TimeUtils.createImage(percent, highlightColor: color)
            self.statusItem.button?.imagePosition = NSCellImagePosition.ImageLeft;
            self.statusItem.button?.bordered = false
        }

        self.statusItem.button?.title = progress;
    }
    func doFinished()
    {
        //update menu
        self.updateMenu()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let noti = NSUserNotification()
            noti.title = "Please stop! Time is up."
            noti.informativeText = "It's time for a coffee break"
            noti.soundName = NSUserNotificationDefaultSoundName
            NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(noti)
        }
    }
    
    //intenal actions
    func updateMenu()
    {
        let status = self.timerRunner?.getStatus();
        
        startItem.enabled = status == TimerStatus.Stopped
        pauseResumeItem.enabled = (status == TimerStatus.Running || status == TimerStatus.Paused)
        pauseResumeItem.title = (status == TimerStatus.Paused) ? "Resume" : "Pause"
        stopItem.enabled = status != TimerStatus.Stopped;
    }
    func doStartTimer(seconds : Int)
    {
        self.lastPercent = 1;
        self.settings.setLatestItem(seconds)
        self.timerRunner!.start(seconds)
        updateMenu()
    }
}
