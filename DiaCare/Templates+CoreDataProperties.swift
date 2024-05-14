//
//  Templates+CoreDataProperties.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//
//

import Foundation
import CoreData

extension Templates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Templates> {
        return NSFetchRequest<Templates>(entityName: "Templates")
    }

    @NSManaged public var name: String
    @NSManaged public var breadCount: String
    @NSManaged public var insulin: String
    @NSManaged public var id: UUID
    @NSManaged public var templateProduct: NSSet?
    @NSManaged public var category: String

}

// MARK: Generated accessors for templateProduct
extension Templates {

    @objc(addTemplateProductObject:)
    @NSManaged public func addToTemplateProduct(_ value: TemplateProduct)

    @objc(removeTemplateProductObject:)
    @NSManaged public func removeFromTemplateProduct(_ value: TemplateProduct)

    @objc(addTemplateProduct:)
    @NSManaged public func addToTemplateProduct(_ values: NSSet)

    @objc(removeTemplateProduct:)
    @NSManaged public func removeFromTemplateProduct(_ values: NSSet)

}

extension Templates: Identifiable {

}
