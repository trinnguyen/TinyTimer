//
//  TimerController.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimerController: NSObject {
    var dataService : DataService
    let statusItem : NSStatusItem
    let selectedSeconds : Int
    var timerRunner : TimerRunner?
    
    let startItem : NSMenuItem
    let pauseResumeItem : NSMenuItem
    let stopItem : NSMenuItem
    
    init(statusItem : NSStatusItem ) {
        
        self.statusItem = statusItem
        self.timerRunner = nil
        
        //default values
        self.dataService = DataService()
        selectedSeconds = self.dataService.getLatestItem()

        //menu
        startItem = NSMenuItem(title: "Start", action: Selector("doStart:"), keyEquivalent: "")
        pauseResumeItem = NSMenuItem(title: "Pause", action: Selector("doPause:"), keyEquivalent: "")
        stopItem = NSMenuItem(title: "Stop", action: Selector("doStop:"), keyEquivalent: "")
        
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
        menu.addItem(NSMenuItem.separatorItem())
//        menu.addItem(perferenceItem)
        menu.addItem(aboutItem)
//        menu.addItem(NSMenuItem.separatorItem())
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
    func doAbout(sender: AnyObject?)
    {
        
    }
    
    func doStart(sender: AnyObject?)
    {
        doStartTimer(self.selectedSeconds)
        updateMenu()
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
    func doUpdateProgress(progress : String, percent : Float64)
    {
        //        _statusItem.Button.Image = ImageFactory.DrawCircleProgress (progress);
        //        _statusItem.Button.ImagePosition = NSCellImagePosition.ImageLeft;
        //        _statusItem.Button.Title = value;
        self.statusItem.button?.title = progress;
    }
    func doFinished()
    {
        //update menu
        self.updateMenu()
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
        self.dataService.setLatestItem(seconds)
        self.timerRunner!.start(seconds)
    }
}
