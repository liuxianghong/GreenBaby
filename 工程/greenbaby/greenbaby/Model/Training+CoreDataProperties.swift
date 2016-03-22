//
//  Training+CoreDataProperties.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/3/22.
//  Copyright © 2016年 刘向宏. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Training {

    @NSManaged var distance: NSNumber?
    @NSManaged var image: NSData?
    @NSManaged var pitch: NSNumber?
    @NSManaged var roll: NSNumber?
    @NSManaged var time: NSDate?
    @NSManaged var yaw: NSNumber?
    @NSManaged var timedisplay: NSNumber?
    @NSManaged var user: User?
    @NSManaged var next: Training?
    @NSManaged var previous: Training?

}
