//
//  DataService.swift
//  TinyTimer
//
//  Created by Tri Ngoc Nguyen on 17/10/2015.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class Settings: NSObject {
    var keyLatest = "kLatestSeconds"
    override init() {
        super.init()
        
        //load preferences
    }
    func getLatestItem() -> Int
    {
        var seconds = NSUserDefaults.standardUserDefaults().integerForKey(self.keyLatest)
        if (seconds <= 0)
        {
            seconds = 60 * 30;
        }
        return seconds;
    }
    func setLatestItem(seconds : Int)
    {
        NSUserDefaults.standardUserDefaults().setInteger(seconds, forKey: self.keyLatest)
    }
    func getHightlightColor() -> NSColor
    {
        return NSColor.blueColor();
    }
    func getNormalColor() -> NSColor
    {
        return NSColor.blackColor();
    }
}
