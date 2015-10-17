//
//  main.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

let delegate = AppDelegate() //alloc main app's delegate class
NSApplication.sharedApplication().delegate = delegate //set as app's delegate

// Old versions:
// NSApplicationMain(C_ARGC, C_ARGV)
NSApplicationMain(Process.argc, Process.unsafeArgv);  //start of run loop