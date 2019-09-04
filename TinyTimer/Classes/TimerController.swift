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
    var customSeconds : Int
    var timerRunner : TimerRunner?
    
    let startItem : NSMenuItem
    let pauseResumeItem : NSMenuItem
    let stopItem : NSMenuItem
    let customItem : NSMenuItem
    let cachedCustomItem : NSMenuItem
    var lastPercent = Float(1);
    let popOver : NSPopover
    var inputViewController : InputViewController?
    
    init(statusItem : NSStatusItem ) {
        
        self.statusItem = statusItem
        self.timerRunner = nil
        
        //default values
        self.settings = Settings()
        selectedSeconds = self.settings.getLatestItem()
        customSeconds = self.settings.getCustomItem()

        //menu
        startItem = NSMenuItem(title: "Start", action: #selector(doStart(sender:)), keyEquivalent: "")
        pauseResumeItem = NSMenuItem(title: "Pause", action: #selector(doPause(sender:)), keyEquivalent: "")
        stopItem = NSMenuItem(title: "Stop", action: #selector(doStop(sender:)), keyEquivalent: "")
        customItem = NSMenuItem(title: "Custom...", action: #selector(doCustom(sender:)), keyEquivalent: "")
        cachedCustomItem = NSMenuItem(title: "", action: #selector(doCustom0(sender:)), keyEquivalent: "")
        
        //popOver
        popOver = NSPopover()
        popOver.behavior = NSPopover.Behavior.transient
        
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
        self.cachedCustomItem.title = self.toMenuString(seconds: self.customSeconds)
        //Suggested Time Items
        let t1Item = NSMenuItem(title: "1 hour", action: #selector(doCustom1(sender:)), keyEquivalent: "")
        let t2Item = NSMenuItem(title: "2 hours", action: #selector(doCustom2(sender:)), keyEquivalent: "")
        let t3Item = NSMenuItem(title: "4 hours", action: #selector(doCustom3(sender:)), keyEquivalent: "")
        
        //Preferences Items
        let aboutItem = NSMenuItem(title: "About", action: #selector(doAbout(sender:)), keyEquivalent: "")
        
        //Quit Items
        let quitItem = NSMenuItem(title: "Quit TinyTimer", action: #selector(doQuit(sender:)), keyEquivalent: "")
        
        let menu = NSMenu()
        menu.autoenablesItems = false
        menu.addItem(startItem)
        menu.addItem(pauseResumeItem)
        menu.addItem(stopItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(cachedCustomItem)
        menu.addItem(t1Item)
        menu.addItem(t2Item)
        menu.addItem(t3Item)
        menu.addItem(customItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(aboutItem)
        menu.addItem(quitItem)
        statusItem.menu = menu
        
        for item in menu.items {
            item.target = self
        }
    }
    
    //Menu action
    @objc func doQuit(sender: AnyObject?) {
        NSApplication.shared.terminate(self)
    }
    @objc func doCustom0(sender: AnyObject?)
    {
        doStartTimer(seconds: self.customSeconds)
    }
    @objc func doCustom1(sender: AnyObject?)
    {
        doStartTimer(seconds: 60 * 60)
    }
    @objc func doCustom2(sender: AnyObject?)
    {
        doStartTimer(seconds: 2 * 60 * 60)
    }
    @objc func doCustom3(sender: AnyObject?)
    {
        doStartTimer(seconds: 4 * 60 * 60)
    }
    @objc func doCustom(sender: AnyObject?)
    {
        if (self.inputViewController == nil)    {
            self.inputViewController = InputViewController(nibName: "InputViewController", bundle: nil)
            self.inputViewController?.actionStart = doCustomStart;
            self.inputViewController?.actionClose = doCustomClose;
            self.popOver.contentViewController = self.inputViewController
        }
        if let button = statusItem.button {
            self.inputViewController!.selectedSeconds = self.selectedSeconds
            self.popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    @objc func doAbout(sender: AnyObject?)
    {
        NSApplication.shared.orderFrontStandardAboutPanel(NSApplication.shared)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    @objc func doStart(sender: AnyObject?)
    {
        doStartTimer(seconds: self.selectedSeconds)
    }
    @objc func doPause(sender: AnyObject?)
    {
        self.timerRunner?.togglePause()
        updateMenu()
    }
    @objc func doStop(sender: AnyObject?)
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
            self.statusItem.button?.image = TimeUtils.createImage(percent: percent, highlightColor: color)
            self.statusItem.button?.imagePosition = NSControl.ImagePosition.imageLeft;
            self.statusItem.button?.isBordered = false
        }

        self.statusItem.button?.title = progress;
    }
    func doFinished()
    {
        //update menu
        self.updateMenu()
        
//        let delayTime = dispatch_time(dispatch_time_t(DispatchTime.now()), Int64(0.5 * Double(NSEC_PER_SEC)))
        let deadlineTime = DispatchTime.now() + .milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let noti = NSUserNotification()
            noti.title = "Please stop! Time is up."
            noti.informativeText = "It's time for a coffee break"
            noti.soundName = NSUserNotificationDefaultSoundName
            NSUserNotificationCenter.default.deliver(noti)
        }
    }
    
    //Custom Popover
    func doCustomStart(seconds : Int)   {
        doStartTimer(seconds: seconds)
        doCustomClose()
        self.updateCustomValue(seconds: seconds)
    }
    func doCustomClose()    {
        self.popOver.close()
    }
    func updateCustomValue(seconds : Int)  {
        //reload
        self.customSeconds = seconds
        self.cachedCustomItem.title = self.toMenuString(seconds: self.customSeconds)
        //save
        self.settings.setLatestCustom(seconds: self.customSeconds)
    }
    
    //intenal actions
    func updateMenu()   {
        let status = self.timerRunner?.getStatus();
        
        startItem.isEnabled = status == TimerStatus.Stopped
        pauseResumeItem.isEnabled = (status == TimerStatus.Running || status == TimerStatus.Paused)
        pauseResumeItem.title = (status == TimerStatus.Paused) ? "Resume" : "Pause"
        stopItem.isEnabled = status != TimerStatus.Stopped;
    }
    func doStartTimer(seconds : Int)    {
        self.selectedSeconds = seconds
        self.lastPercent = 1;
        self.settings.setLatestItem(seconds: self.selectedSeconds)
        self.timerRunner!.start(seconds: self.selectedSeconds)
        updateMenu()
    }
    func toMenuString(seconds: Int) -> String   {
        return TimeUtils.convertTicksToMenu(ticks: seconds)
    }
}
