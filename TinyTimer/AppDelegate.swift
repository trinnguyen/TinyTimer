//
//  AppDelegate.swift
//  TinyTimer
//
//  Created by Tri Nguyen on 9/4/19.
//  Copyright © 2019 Tri Nguyen. All rights reserved.
//

import Cocoa
var timerController : TimerController!

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        timerController = TimerController(statusItem: statusItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

