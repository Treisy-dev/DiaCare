//
//  CoreDataManager.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 31.03.2024.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveContext()
    func setUpDefaultProductTypes()
    func obtainAllTypes()
    func deleteAllTypes()
    func obtainCategoryFromProduct(for word: String) -> String?
}

final class CoreDataManager: CoreDataManagerProtocol {

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DiaCare")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func setUpDefaultProductTypes() {
        let fruits = [
            "apple", "banana", "orange", "grape", "strawberry", "pear", "kiwi", "mango", "pineapple",
            "melon", "watermelon", "cherry", "apricot", "peach", "plum", "nectarine", "persimmon",
            "pomegranate", "dates", "fig", "lemon", "lime", "grapefruit", "pomelo", "mandarin",
            "papaya", "rambutan", "lychee", "mangosteen", "star fruit", "durian"
        ]

        let vegetables = [
            "cucumber", "tomato", "cabbage", "carrot", "onion", "potato", "beetroot", "eggplant",
            "pepper", "zucchini", "garlic", "pumpkin", "asparagus", "broccoli", "cauliflower",
            "Brussels sprouts", "peas", "beans", "corn", "greens", "mushrooms"
        ]

        let cereals = [
            "rice", "buckwheat", "millet", "oatmeal", "pearl barley", "barley", "corn grits",
            "semolina", "bulgur", "quinoa", "couscous"
        ]

        let fish = [
            "herring", "salmon", "tuna", "cod", "hake", "pollock", "mackerel", "sole", "trout", "carp",
            "catfish", "perch", "pike", "bream", "pike-perch", "crucian carp", "tilapia", "dorado", "seabass"
        ]

        let meat = [
            "chicken", "beef", "pork", "lamb", "turkey", "rabbit", "lamb", "horse meat", "game meat",
            "sausage", "sausages", "ham", "brisket", "pork knuckle"
        ]

        let categories = ["fruit", "vegetable", "cereal", "fish", "meat"]
        let foods = [fruits, vegetables, cereals, fish, meat]

        for (category, foodList) in zip(categories, foods) {
            for food in foodList {
                let productType = ProductTypes(context: viewContext)
                productType.name = food
                productType.category = category
                productType.id = UUID()
            }
        }

        saveContext()
    }

    func obtainAllTypes() {
        let typesFetchRequest = ProductTypes.fetchRequest()
        guard let results = try? viewContext.fetch(typesFetchRequest) else { return }
        for type in results {
            print(type.name)
        }
    }

    func deleteAllTypes() {
        let typesFetchRequest = ProductTypes.fetchRequest()
        guard let results = try? viewContext.fetch(typesFetchRequest) else { return }
        for type in results {
            viewContext.delete(type)
        }
        saveContext()
    }

    func obtainCategoryFromProduct(for word: String) -> String? {
        let typesFetchRequest = ProductTypes.fetchRequest()
        typesFetchRequest.predicate = NSPredicate(format: "name == %@", word)

        do {
            let results = try viewContext.fetch(typesFetchRequest)
            if let productType = results.first {
            return productType.category
            }
        } catch {
            print("Ошибка при получении категории: \(error)")
        }

        return nil
    }
}
