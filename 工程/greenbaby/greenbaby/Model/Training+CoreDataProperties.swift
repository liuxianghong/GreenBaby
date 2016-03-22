//
//  Training+CoreDataProperties.swift
//  greenbaby
//
//  Created by 刘向宏 on 16/3/20.
//  Copyright © 2016年 刘向宏. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Training {

    @NSManaged var time: NSDate?
    @NSManaged var roll: NSNumber?
    @NSManaged var distance: NSNumber?
    @NSManaged var pitch: NSNumber?
    @NSManaged var yaw: NSNumber?
    @NSManaged var image: NSData?
    @NSManaged var user: User?

}
