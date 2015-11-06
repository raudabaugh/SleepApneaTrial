//
//  ViewController.swift
//  SleepApneaTrial
//
//  Created by Samuel Raudabaugh on 10/25/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import Granola
import HealthKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let hm = HealthManager()
        hm.authorizeHealthKit(nil)
        
        let calendar = NSCalendar.currentCalendar()
        
        let interval = NSDateComponents()
        interval.hour = 1
        
        // Set the anchor date to Monday at 3:00 a.m.
        let anchorComponents =
        calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: NSDate())
        
        let anchorDate = calendar.dateFromComponents(anchorComponents)
        
        let quantityType =
        HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        
        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: quantityType!,
            quantitySamplePredicate: nil,
            options: .CumulativeSum,
            anchorDate: anchorDate!,
            intervalComponents: interval)
        
        // Set the results handler
        query.initialResultsHandler = {
            query, results, error in
            
            if error != nil {
                // Perform proper error handling here
                print("*** An error occurred while calculating the statistics: \(error?.localizedDescription) ***")
                abort()
            }
            
            let endDate = NSDate()
            let startDate =
            calendar.dateByAddingUnit(NSCalendarUnit.Day,
                value: -14, toDate: endDate, options: [])
            
            // Plot the weekly step counts over the past 3 months
            results?.enumerateStatisticsFromDate(startDate!, toDate: endDate) {
                statistics, stop in
                
                if let quantity = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let value = quantity.doubleValueForUnit(HKUnit.countUnit())
                    
                    print(date)
                    print(value)
//                    self.plotData(value, forDate: date)
                }
            }
        }
        
        hm.healthKitStore.executeQuery(query)
        
//        let stepsSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
//        
//        let calendar = NSCalendar.currentCalendar()
//        let now = NSDate(timeIntervalSince1970: 467510400)
//        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: now)
//        
//        let startDate = calendar.dateFromComponents(components)
//        
//        let endDate = calendar.dateByAddingUnit(.Day, value: 7, toDate: startDate!, options: [])
//        
//        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate,
//            endDate: endDate, options: .StrictStartDate)
//        
//        let query = HKStatisticsQuery(quantityType: stepsSampleType!, quantitySamplePredicate: predicate, options: .CumulativeSum) { query, result, error in
//            if let queryError = error {
//                return
//            }
//            
//            if let quantity = result {
//                print(quantity.sumQuantity())
//            }
//            
//        }
//        hm.healthKitStore.executeQuery(query)
//        let sampleQuery = HKSampleQuery(sampleType: stepsSampleType!, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil)
//            { (sampleQuery, results: [HKSample]?, error ) -> Void in
        
//                if let queryError = error {
//                    completion(nil,error)
//                    return;
//                }
                
                // Get the first sample
//                if let samples = results {
//                    for sample in samples {
//                        let serializer = OMHSerializer()
//                        let json = try serializer.jsonForSample(sample)
//                        print(json)
//                        do {
//                        try self.printSample(sample)
//                        } catch {}
//                    }
//                }
                
                // Execute the completion closure
//                if completion != nil {
//                    completion(mostRecentSample,nil)
//                }
//        }
//        hm.healthKitStore.executeQuery(sampleQuery)
    }
    
    func printSample(sample: HKSample) throws {
        let serializer = OMHSerializer()
        let json = try serializer.jsonForSample(sample)
        print(json)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

