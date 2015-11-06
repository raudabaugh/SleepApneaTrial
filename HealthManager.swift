//
//  HealthManager.swift
//  SleepApneaTrial
//
//  Created by Samuel Raudabaugh on 10/26/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import HealthKit
import UIKit

class HealthManager: NSObject {
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((success: Bool, error: NSError!) -> Void)!) {
        var readTypes = Set<HKObjectType>()
        readTypes.insert(HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!)
        // Read from HK Store
        healthKitStore.requestAuthorizationToShareTypes(nil, readTypes: readTypes) { (success, error) -> Void in
        }
    }
}
