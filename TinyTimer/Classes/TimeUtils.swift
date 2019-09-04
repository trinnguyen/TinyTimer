//
//  TimeUtils.swift
//  TinyTimer
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
//

import Cocoa

class TimeUtils: NSObject {
    static func convertTicksToMenu(ticks: Int) -> String  {
        var result = ""
        if ticks > 0    {
            let hours = ticks / 3600
            let minTicks = ticks - hours * 3600
            let minutes = minTicks / 60
            let seconds = minTicks - minutes * 60
            if hours > 0    {
                var fmt = ""
                if hours > 1    {
                    fmt = "%d hours "
                }   else    {
                    fmt = "%d hour "
                }
                result = String(format: fmt, hours)
            }
            if minutes > 0  {
                var fmt = ""
                if minutes > 1  {
                    fmt = "%@%d minutes "
                }   else    {
                    fmt = "%@%d minute "
                }
                result = String(format: fmt, result, minutes)
            }
            if seconds > 0  {
                var fmt = ""
                if seconds > 1  {
                    fmt = "%@%d seconds"
                }   else    {
                    fmt = "%@%d second"
                }
                result = String(format: fmt, result, seconds)
            }
            if result.count > 0  {
                if result.last! == " "       {
                    result = String(result.dropLast())
                }
            }
        }   else    {
            result = "0 second"
        }
        return result;
    }
    static func convertTicksToTime(ticks: Int) -> String    {
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
    static func createImage(percent : Float, highlightColor : NSColor) -> NSImage
    {
        let s = CGFloat(18);
        let imgRect = CGRect (x: 0, y: 0, width: s, height: s);
        let imgSize = imgRect.size;
        let offScreenRep = NSBitmapImageRep(bitmapDataPlanes: nil,
            pixelsWide: Int(imgSize.width),
            pixelsHigh: Int(imgSize.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: NSColorSpaceName.deviceRGB,
            bytesPerRow: 0, bitsPerPixel: 0)!
        
        let g = NSGraphicsContext(bitmapImageRep: offScreenRep)
        NSGraphicsContext.saveGraphicsState()

        //context
        NSGraphicsContext.current = g
        let context = g!.cgContext
        let pad = CGFloat(1)
        context.setLineWidth(pad)
        let drawRect = CGRect (x: pad, y: pad, width: s - pad * 2, height: s - pad * 2)
        
        NSColor.clear.setFill()
        context.fill(drawRect)
        
        //draw circle border
        highlightColor.setFill()
        highlightColor.setStroke()
        context.strokeEllipse(in: drawRect)
        
        let r = drawRect.size.width / 2
        let center = NSPoint (x: r + pad, y: r + pad)
        
        //draw progress
        let path = NSBezierPath ()
        path.lineWidth = pad
        
        path.move(to: NSPoint(x: r + pad, y: r * 2 + pad))
        path.line(to: center)

        let start = CGFloat((percent) * 360) + CGFloat(90)
        let end = CGFloat(90)

        path.appendArc(withCenter: center, radius: CGFloat(r), startAngle: start, endAngle: end)
        path.close()
        
        path.fill ()
        path.stroke()

        NSGraphicsContext.restoreGraphicsState()
        let image = NSImage (size: imgSize)
        image.addRepresentation (offScreenRep)
        return image;
    }
}
