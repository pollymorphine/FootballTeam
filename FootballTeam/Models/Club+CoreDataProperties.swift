//
//  Club+CoreDataProperties.swift
//  FootballTeam
//
//  Created by Polina on 14.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//
//

import Foundation
import CoreData


extension Club {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Club> {
        return NSFetchRequest<Club>(entityName: "Club")
    }

    @NSManaged public var name: String?
    @NSManaged public var player: NSSet?

}

// MARK: Generated accessors for player
extension Club {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: Player)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: Player)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}
