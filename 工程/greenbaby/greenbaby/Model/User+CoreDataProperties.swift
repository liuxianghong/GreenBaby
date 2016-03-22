//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var uid: NSNumber?
    @NSManaged var ip: String?
    @NSManaged var training: Training?
    @NSManaged var lastTraining: Training?

}
