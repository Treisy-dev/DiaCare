//
//  UserProducts+CoreDataProperties.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//
//

import Foundation
import CoreData

extension UserProducts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProducts> {
        return NSFetchRequest<UserProducts>(entityName: "UserProducts")
    }

    @NSManaged public var name: String?
    @NSManaged public var protein: String?
    @NSManaged public var fat: String?
    @NSManaged public var grams: String?
    @NSManaged public var carbohydrates: String?
    @NSManaged public var category: String?

}

extension UserProducts: Identifiable {

}
