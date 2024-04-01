//
//  PushNotification+CoreDataProperties.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//
//

import Foundation
import CoreData

extension PushNotification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PushNotification> {
        return NSFetchRequest<PushNotification>(entityName: "PushNotification")
    }

    @NSManaged public var title: String?
    @NSManaged public var message: String?
    @NSManaged public var date: Date?
    @NSManaged public var isRead: Bool
    @NSManaged public var id: UUID?

}

extension PushNotification: Identifiable {

}
