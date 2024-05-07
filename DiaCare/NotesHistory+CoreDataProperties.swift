//
//  NotesHistory+CoreDataProperties.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//
//

import Foundation
import CoreData

extension NotesHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesHistory> {
        return NSFetchRequest<NotesHistory>(entityName: "NotesHistory")
    }

    @NSManaged public var sugar: Double
    @NSManaged public var breadCount: Double
    @NSManaged public var shortInsulin: Double
    @NSManaged public var date: Date
    @NSManaged public var id: UUID?
    @NSManaged public var longInsulin: Double

}

extension NotesHistory: Identifiable {

}
