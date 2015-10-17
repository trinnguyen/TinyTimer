//
//  TimeUtils.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimeUtils: NSObject {
    static func convertTicksToTime(ticks: Int) -> String
    {
        let hours = ticks / 3600
        let minTicks = ticks - hours * 3600
        let minutes = minTicks / 60
        let seconds = minTicks - minutes * 60
        var result = ""
        if (hours > 0)
        {
            result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }   else    {
            result = String(format: "%02d:%02d", minutes, seconds)
        }
        return result;
    }
    /*public static string ConvertTicksToTime(long ticks)
    {
    long hours = ticks / 3600;
    long minTicks = ticks - hours * 3600;
    long minutes = minTicks / 60;
    long seconds = minTicks - minutes * 60;
    string result = "";
    if (hours > 0)
    {
				result = String.Format("{0}:{1:00}:{2:00}", hours, minutes, seconds);
    }   else    {
				result = String.Format("{0:00}:{1:00}", minutes, seconds);
    }
    return result;
    }*/
}
