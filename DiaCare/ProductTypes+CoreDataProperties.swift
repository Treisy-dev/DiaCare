//
//  ProductTypes+CoreDataProperties.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//
//

import Foundation
import CoreData

extension ProductTypes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductTypes> {
        return NSFetchRequest<ProductTypes>(entityName: "ProductTypes")
    }

    @NSManaged public var name: String
    @NSManaged public var category: String
    @NSManaged public var id: UUID

}

extension ProductTypes: Identifiable {

}
