//
//  Recents.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/14/16.
//  Copyright © 2016 USF. All rights reserved.
//

import Foundation

class Recents {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var allHistory: [String] {
        get { return defaults.objectForKey(Constants.NSUserDefaultKey) as? [String] ?? [] }
        set { defaults.setObject(newValue, forKey: Constants.NSUserDefaultKey) }
    }
    
    func removeAtIndex(index: Int) {
        var history = allHistory
        history.removeAtIndex(index)
        allHistory = history
    }
    
    private struct Constants {
        static let NSUserDefaultKey = "SmashTagRecentsNSUserDefaultKey"
    }

}