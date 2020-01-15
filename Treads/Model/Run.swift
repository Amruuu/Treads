//
//  Run.swift
//  Treads
//
//  Created by Amr on 12/6/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import Foundation
import RealmSwift


class Run: Object {
   @objc  dynamic public private(set) var id = ""
   @objc  dynamic public private(set) var duration = 0
   @objc  dynamic public private(set) var pace = 0
   @objc  dynamic public private(set) var distance = 0.0
   @objc  dynamic public private(set) var date = NSDate()
   public private(set) var locations = List<Locationss>()
    
    override class func primaryKey() -> String{
        return "id"
    }
    override class func indexedProperties() -> [String]{
        return ["duration", "pace", "date"]
    }

    convenience init(duration: Int, pace: Int, distance: Double, locationz: List<Locationss>){
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.duration = duration
        self.pace = pace
        self.distance = distance
        self.locations = locationz
    }
    
    static func addRunToRealm(duration: Int, pace: Int, distance: Double, locations: List<Locationss>){
        DispatchQueue.init(label: "realmQue").sync {
            autoreleasepool {
                let MyRun = Run.init(duration: duration, pace: pace, distance: distance, locationz: locations)
                let realm = try! Realm()
                try! realm.write {
                    realm.add(MyRun)
                    try! realm.commitWrite()
                 }
            }
        }}
    
    static func getAllRuns() -> Results<Run>? {
        do {
          let realm = try! Realm()
          var runs =  realm.objects(Run.self)
          //last run come first  ....> ascending y3ny tasa3ody .. a2dam taree5 we atla3 Le a7das tare5
          runs = runs.sorted(byKeyPath: "date", ascending: false)
          return runs
        } catch {
            return nil
        }
    }
    
}








