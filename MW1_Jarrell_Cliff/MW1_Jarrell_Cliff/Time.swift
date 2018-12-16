//
//  Time.swift
//  MW1_Jarrell_Cliff
//
//  Created by Clifford Kyle Jarrell on 9/26/18.
//  Copyright © 2018 OSU CS Department. All rights reserved.
//

import Foundation
public class Time {
    
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    private var tenths: Int = 0
    
    public var time: String {
        get {
            return (format(time: hours) + ":" + format(time: minutes) + ":" + format(time: seconds) + "." + String(tenths))
        }
    }
    
    // method that aids in calculating the average of lap times
    public var timeInTenths: Int {
        get {
            
            var result: Int = 0
            
            result += (hours * 36000)
            result += (minutes * 600)
            result += (seconds * 10)
            result += tenths
            
            return result
        }
    }
    
    public init() {
        
    }
    
    // used later to format the average of lap times
    public init(tenths: Int) {
        
        for _ in 0..<tenths {
            increment()
        }
        
    }
    
    public init(hours: Int, minutes: Int, seconds: Int, tenths: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.tenths = tenths
    }
    
    
    // increment the time by a tenth of a second
    public func increment() {
        tenths+=1
        if tenths > 9 {
            tenths = 0
            seconds+=1
            if seconds > 59 {
                seconds = 0
                minutes+=1
                if minutes > 59 {
                    minutes = 0
                    hours+=1
                }
            }
        }
    }
    
    
    // prepends a 0 to the time if needed
    private func format(time: Int) -> String {
        
        var result: String = String(time)
        
        if time < 10 {
            result = "0" + result
        }
        
        return result
    }
    
    public func reset() {
        hours = 0
        minutes = 0
        seconds = 0
        tenths = 0
    }
    
    public func clone() -> Time {
        return Time(hours: self.hours, minutes: self.minutes, seconds: self.seconds, tenths: self.tenths)
    }
}
