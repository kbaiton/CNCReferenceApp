//
//  SavedCalculation.swift
//  CNCReferenceApp
//
//  Created by Kale Baiton on 2017-08-14.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import Foundation

class SavedCalculation: NSObject, NSCoding {
    
    var name: NSString = ""
    var bitDiameter: NSNumber = 0
    var spindleSpeed: NSNumber = 0
    var numberOfFlutes: NSNumber = 0
    var chipLoad: NSNumber = 0
    var feedRate: NSNumber = 0
    
    required convenience init(coder decoder: NSCoder) {
        
        self.init()
        
        self.name = decoder.decodeObject(of: NSString.self, forKey: "name") ?? ""
        self.bitDiameter = decoder.decodeObject(of: NSNumber.self, forKey: "bitDiameter") ?? 0
        self.spindleSpeed = decoder.decodeObject(of: NSNumber.self, forKey: "spindleSpeed") ?? 0
        self.numberOfFlutes = decoder.decodeObject(of: NSNumber.self, forKey: "numberOfFlutes") ?? 0
        self.chipLoad = decoder.decodeObject(of: NSNumber.self, forKey: "chipLoad") ?? 0
        self.feedRate = decoder.decodeObject(of: NSNumber.self, forKey: "feedRate") ?? 0
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.bitDiameter, forKey: "bitDiameter")
        coder.encode(self.spindleSpeed, forKey: "spindleSpeed")
        coder.encode(self.numberOfFlutes, forKey: "numberOfFlutes")
        coder.encode(self.chipLoad, forKey: "chipLoad")
        coder.encode(self.feedRate, forKey: "feedRate")
    }
}
