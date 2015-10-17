//
//  TimerController.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimerController: NSObject {
    var statusItem : NSStatusItem;
    var selectedSeconds : Int64;
    var timerRunner : TimerRunner;
    
    var startItem : NSMenuItem;
    var pauseResumeItem : NSMenuItem;
    var stopItem : NSMenuItem;
    
    init(statusItem : NSStatusItem ) {
        self.statusItem = statusItem;
        
        //default values
        selectedSeconds = 10;
        timerRunner = TimerRunner(actionUpdateProgress: Selector("doUpdateProgress:"), actionFinished: Selector("doFinished"), seconds: self.selectedSeconds);

        //menu
        startItem = NSMenuItem(title: "Start", action: Selector("doStart:"), keyEquivalent: "");
        pauseResumeItem = NSMenuItem(title: "Pause", action: Selector("doPause:"), keyEquivalent: "");
        stopItem = NSMenuItem(title: "Stop", action: Selector("doStop:"), keyEquivalent: "");
        
        super.init();
        
        //init menu
        self.initMenuItems();
        
        //update menu
        self.updateMenu();
        
    }
    func updateMenu()
    {
        statusItem.title = "Test nguywn";
    }
    func doUpdateProgress(sender : NSObject)
    {
    }
    func doFinished(sender : NSObject)
    {
    }
    func doQuit(sender : NSObject)
    {
        NSApplication.sharedApplication().terminate(self);
    }
    func initMenuItems()
    {
        //Control Items

        
        //Suggested Time Items
        let t0Item = NSMenuItem(title: "30 minutes", action: Selector("doStop:"), keyEquivalent: "");
        let t1Item = NSMenuItem(title: "1 hour", action: Selector("doCustom:"), keyEquivalent: "");
        let t2Item = NSMenuItem(title: "2 hours", action: Selector("doCustom:"), keyEquivalent: "");
        let t3Item = NSMenuItem(title: "4 hours", action: Selector("doCustom:"), keyEquivalent: "");
        
        //Preferences Items
        let perferenceItem = NSMenuItem(title: "Preferences", action: Selector("doPreferences:"), keyEquivalent: "");
        let aboutItem = NSMenuItem(title: "About", action: Selector("doAbout:"), keyEquivalent: "");
        
        //Quit Items
        let quitItem = NSMenuItem(title: "Quit", action: Selector("doQuit:"), keyEquivalent: "");
        
        let menu = NSMenu();
        menu.autoenablesItems = false;
        menu.addItem(startItem);
        menu.addItem(pauseResumeItem);
        menu.addItem(stopItem);
        menu.addItem(NSMenuItem.separatorItem());
        menu.addItem(t0Item);
        menu.addItem(t1Item);
        menu.addItem(t2Item);
        menu.addItem(t3Item);
        menu.addItem(NSMenuItem.separatorItem());
        menu.addItem(perferenceItem);
        menu.addItem(aboutItem);
        menu.addItem(NSMenuItem.separatorItem());
        menu.addItem(quitItem);
        statusItem.menu = menu;
    }
}
