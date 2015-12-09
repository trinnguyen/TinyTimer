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
    func getLatestItem(defaultSeconds: Int) -> Int
    {
        let seconds = NSUserDefaults.standardUserDefaults().integerForKey(self.keyLatest)
        if (seconds <= 0)
        {
            return defaultSeconds
        }
        return seconds
    }
    func setLatestItem(seconds : Int)
    {
        NSUserDefaults.standardUserDefaults().setInteger(seconds, forKey: self.keyLatest)
    }
}
