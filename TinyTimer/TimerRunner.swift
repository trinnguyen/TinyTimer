//
//  TimerRunner.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimerRunner: NSObject {
    var actionUpdateProgress: (progress: String, precent : Float, force : Bool) -> Void
    var actionFinished: () -> Void
    var seconds : Int
    var cachedSeconds : Int
    var status : TimerStatus
    var timer : NSTimer?
    
    var isPausing : Bool
    
    init (actionUpdateProgress : (progress : String, precent : Float, force : Bool) -> Void, actionFinished : () -> Void, seconds : Int) {
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
        //start working
        self.cachedSeconds = seconds;
        self.seconds = seconds;
     
        if (self.seconds > 0)   {
            //stop if needed
            if (self.timer != nil) {
                self.timer?.invalidate()
                self.timer = nil
            }
            

            self.timer = NSTimer.init(timeInterval: 1, target: self, selector: Selector("doTick:"), userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
            self.isPausing = false
            self.updateUI(true)
        }   else    {
            self.stop()
        }
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
        self.updateUI(false)
    }
    func updateUI(force : Bool)
    {
        let val = TimeUtils.convertTicksToTime(self.seconds);
        let percent = Float(self.seconds) / Float(self.cachedSeconds)
        self.actionUpdateProgress(progress: val, precent:percent, force : force)
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
