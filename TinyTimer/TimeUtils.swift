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
    static func createImage(percent : Float) -> NSImage
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
            colorSpaceName: NSDeviceRGBColorSpace,
            bytesPerRow: 0, bitsPerPixel: 0)!
        
        let g = NSGraphicsContext(bitmapImageRep: offScreenRep)
        NSGraphicsContext.saveGraphicsState()

        //context
        NSGraphicsContext.setCurrentContext(g)
        let context = g?.CGContext
        let pad = CGFloat(1)
        CGContextSetLineWidth(context, pad)
        let drawRect = CGRect (x: pad, y: pad, width: s - pad * 2, height: s - pad * 2)
        
        NSColor.clearColor().setFill()
        CGContextFillRect(context, drawRect)
        
        //draw circle border
        NSColor.blackColor().setFill()
        NSColor.blackColor().setStroke()
        CGContextStrokeEllipseInRect(context, drawRect)
        
        let r = drawRect.size.width / 2
        let center = NSPoint (x: r + pad, y: r + pad)
        
        //draw progress
        let path = NSBezierPath ()
        path.lineWidth = pad
        
        path.moveToPoint(NSPoint(x: r + pad, y: r * 2 + pad))
        path.lineToPoint(center)

        let start = CGFloat((percent) * 360) + CGFloat(90)
        let end = CGFloat(90)

        path.appendBezierPathWithArcWithCenter(center, radius: CGFloat(r), startAngle: start, endAngle: end)
        path.closePath()
        
        path.fill ()
        path.stroke()

        NSGraphicsContext.restoreGraphicsState()
        let image = NSImage (size: imgSize)
        image.addRepresentation (offScreenRep)
        return image;
    }
}
