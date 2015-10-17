//
//  TimerRunner.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimerRunner: NSObject {
    var actionUpdateProgress: (progress: String, precent : Float64) -> Void
    var actionFinished: () -> Void
    var seconds : Int
    var cachedSeconds : Int
    var status : TimerStatus
    var timer : NSTimer?
    
    var isPausing : Bool
    
//    override init() {
//        self.actionUpdateProgress = Void
//        self.actionFinished = Void
//        seconds = 0
//        super.init()
//    }
    
    init (actionUpdateProgress : (progress : String, precent : Float64) -> Void, actionFinished : () -> Void, seconds : Int) {
        self.actionUpdateProgress = actionUpdateProgress
        self.actionFinished = actionFinished
        self.seconds = seconds
        self.cachedSeconds = seconds
        self.isPausing = false
        self.status = TimerStatus.Stopped
        self.timer = nil
        super.init()
        
        //start updating UI
        self.updateUI()
    }
    func start(seconds : Int)
    {
        //stop if needed
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        //start working
        self.cachedSeconds = seconds;
        self.seconds = seconds;
        self.timer = NSTimer.init(timeInterval: 1, target: self, selector: Selector("doTick:"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSDefaultRunLoopMode)
        self.isPausing = false
        self.updateUI()
    }
    func stop()
    {
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
        self.seconds = self.cachedSeconds
        self.updateUI()
    }
    func togglePause()
    {
        self.isPausing = !self.isPausing
    }
    func updateUI()
    {
        let val = TimeUtils.convertTicksToTime(self.seconds);
        let percent = (Float64)(self.seconds / self.cachedSeconds)
        self.actionUpdateProgress(progress: val, precent:percent)
    }
    func doTick(sender : AnyObject?)
    {
        if (!self.isPausing) {
            self.seconds = self.seconds - 1;
            self.updateUI();
            if (self.seconds == 0) {
                self.stop()
                self.actionFinished()
            }
        }
    }
    func getStatus() -> TimerStatus{
        if (self.timer != nil) {
            if (self.isPausing) {
                return TimerStatus.Paused
            } else  {
                return TimerStatus.Running
            }
        } else {
            return TimerStatus.Stopped
        }
    }
}
enum TimerStatus
{
    case Stopped
    case Running
    case Paused
}
