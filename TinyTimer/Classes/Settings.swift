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
    var keyCustom = "kCustomsSeconds"
    override init() {
        super.init()
    }

    func getCustomItem() -> Int
    {
        return get(key: self.keyCustom)
    }
    func setLatestCustom(seconds : Int)
    {
        update(seconds: seconds, key: self.keyCustom)
    }
    func getLatestItem() -> Int
    {
        return get(key: self.keyLatest)
    }
    func setLatestItem(seconds : Int)
    {
        update(seconds: seconds, key: self.keyLatest)
    }
    
    // Internal functions
    
    func get(key : String) -> Int
    {
        let seconds = UserDefaults.standard.integer(forKey: key)
        if (seconds <= 0)
        {
            return Builds.defaultTimers
        }
        return seconds
    }
    func update(seconds : Int, key : String)
    {
        UserDefaults.standard.set(seconds, forKey: key)
    }
}
