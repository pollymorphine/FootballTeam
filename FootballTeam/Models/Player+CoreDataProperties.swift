//
//  Player+CoreDataProperties.swift
//  FootballTeam
//
//  Created by Polina on 14.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var age: Int16
    @NSManaged public var fullName: String?
    @NSManaged public var image: NSObject?
    @NSManaged public var nationality: String?
    @NSManaged public var number: Int16
    @NSManaged public var position: String?
    @NSManaged public var team: String?
    @NSManaged public var club: Club?

}
