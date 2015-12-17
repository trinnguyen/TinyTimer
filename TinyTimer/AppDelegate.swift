//
//  AppDelegate.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa
//import Fabric
//import Crashlytics

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var timerController : TimerController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //track crash
//        Fabric.with([Crashlytics.self])

        //default controller
        let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        timerController = TimerController(statusItem: statusItem)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}