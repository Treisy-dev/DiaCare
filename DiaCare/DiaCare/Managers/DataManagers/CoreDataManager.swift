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
    func obtainUsersProduct() -> [UserProducts]
    func addToHistory(breadCount: String, sugar: String, shortInsulin: String, longInsulin: String)
    func obtainAverageSugar() -> String
    func obtainAllCategories() -> [String]
    func addUserProduct(category: String, name: String, protein: String, fat: String, carbs: String)
    func addNewNotification(message: String, title: String, date: Date)
    func obtainUserNotifications() -> [PushNotification]
    func obtainAllSugarWithDateHistory(from startDate: Date, to endDate: Date) -> [(Double, Date)]
    func obtainBreadCountBy(from startDate: Date, to endDate: Date) -> Double
    func obtainShortInsulinCountBy(from startDate: Date, to endDate: Date) -> Double
    func obtainLongInsulinCountBy(from startDate: Date, to endDate: Date) -> Double
    func obtainHistoryBy(from startDate: Date, to endDate: Date) -> [NotesHistory]
    func obtainUsersTemplates() -> [Templates]
    func addNewTemplate(breadCount: String, shortInsulin: String, templateName: String, category: String, products: [UserProductModel])
    func obtainCategoryFromTemplate(for word: String) -> String?
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

    func obtainAllCategories() -> [String] {
        var categories: Set<String> = Set<String>()
        let categoryFetchRequest = ProductTypes.fetchRequest()
        categoryFetchRequest.returnsDistinctResults = true
        categoryFetchRequest.propertiesToFetch = ["category"]

        do {
            let result = try viewContext.fetch(categoryFetchRequest)
            for product in result {
                categories.insert(product.category)
            }
            return Array(categories)
        } catch {
            print("Error fetching unique categories: \(error)")
        }

        return Array(categories)
    }

    func obtainUsersProduct() -> [UserProducts] {
        let userProductsFetchRequest = UserProducts.fetchRequest()

        do {
            let result = try viewContext.fetch(userProductsFetchRequest)
            return result
        } catch {
            print("Ошибка при получении продуктов пользователя: \(error)")
        }

        return []
    }

    func addToHistory(breadCount: String, sugar: String, shortInsulin: String, longInsulin: String) {
        guard let breadCount = Double(breadCount),
            let sugar = Double(sugar),
            let shortInsulin = Double(shortInsulin),
            let longInsulin = Double(longInsulin) else { return }
        let newNote = NotesHistory(context: viewContext)
        newNote.id = UUID()
        newNote.date = Date()
        newNote.breadCount = breadCount
        newNote.sugar = sugar
        newNote.shortInsulin = shortInsulin
        newNote.longInsulin = longInsulin

        saveContext()
    }

    func addUserProduct(category: String, name: String, protein: String, fat: String, carbs: String) {
        let userProduct = UserProducts(context: viewContext)
        userProduct.category = category
        userProduct.name = name
        userProduct.protein = protein
        userProduct.fat = fat
        userProduct.carbohydrates = carbs

        let productType = ProductTypes(context: viewContext)
        productType.id = UUID()
        productType.category = category
        productType.name = name

        saveContext()
    }

    func obtainUserNotifications() -> [PushNotification] {
        let notificationFetchRequest = PushNotification.fetchRequest()
        do {
            return try viewContext.fetch(notificationFetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    func addNewNotification(message: String, title: String, date: Date) {
        let notification = PushNotification(context: viewContext)
        notification.id = UUID()
        notification.date = date
        notification.title = title
        notification.message = message

        saveContext()
    }

    func obtainAllSugarWithDateHistory(from startDate: Date, to endDate: Date) -> [(Double, Date)] {
        let historyFetchRequest = NotesHistory.fetchRequest()

        historyFetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        do {
            let result = try viewContext.fetch(historyFetchRequest)
            var sugarArray: [(Double, Date)] = []
            for note in result {
                sugarArray.append((note.sugar, note.date))
            }
            return sugarArray
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    func obtainHistoryBy(from startDate: Date, to endDate: Date) -> [NotesHistory] {
        let historyFetchRequest = NotesHistory.fetchRequest()

        historyFetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        do {
            let result = try viewContext.fetch(historyFetchRequest)
            return result.sorted { $0.date > $1.date }
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    func obtainBreadCountBy(from startDate: Date, to endDate: Date) -> Double {
        let historyFetchRequest = NotesHistory.fetchRequest()

        historyFetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        do {
            let result = try viewContext.fetch(historyFetchRequest)
            var breadCount: Double = 0
            for note in result {
                breadCount += note.breadCount
            }
            return breadCount
        } catch {
            print("Error fetching data: \(error)")
            return 0
        }
    }

    func obtainShortInsulinCountBy(from startDate: Date, to endDate: Date) -> Double {
        let historyFetchRequest = NotesHistory.fetchRequest()

        historyFetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        do {
            let result = try viewContext.fetch(historyFetchRequest)
            var insulinCount: Double = 0
            for note in result {
                insulinCount += note.shortInsulin
            }
            return insulinCount
        } catch {
            print("Error fetching data: \(error)")
            return 0
        }
    }

    func obtainLongInsulinCountBy(from startDate: Date, to endDate: Date) -> Double {
        let historyFetchRequest = NotesHistory.fetchRequest()

        historyFetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as CVarArg, endDate as CVarArg)

        do {
            let result = try viewContext.fetch(historyFetchRequest)
            var insulinCount: Double = 0
            for note in result {
                insulinCount += note.longInsulin
            }
            return insulinCount
        } catch {
            print("Error fetching data: \(error)")
            return 0
        }
    }

    func obtainAverageSugar() -> String {
        let notesHistoryFetchRequest = NotesHistory.fetchRequest()
        let calendar = Calendar.current
        let now = Date()

        guard let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: now) else { return "5.5"}

        notesHistoryFetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", oneMonthAgo as CVarArg, Date() as CVarArg)

        do {
            let results = try viewContext.fetch(notesHistoryFetchRequest)
            let sugarValues = results.compactMap { $0.sugar }
            let averageSugar = sugarValues.reduce(0, +) / Double(sugarValues.count)
            return sugarValues.count != 0 ? String(format: "%.1f", averageSugar) : "5.5"
        } catch {
            print("Error fetching data: \(error)")
            return "5.5"
        }
    }

    func obtainUsersTemplates() -> [Templates] {
        let templatesFetchRequest = Templates.fetchRequest()
        do {
            let result = try viewContext.fetch(templatesFetchRequest)
            return result
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    func addNewTemplate(breadCount: String, shortInsulin: String, templateName: String, category: String, products: [UserProductModel]) {
        let newTemplate = Templates(context: viewContext)
        newTemplate.id = UUID()
        newTemplate.breadCount = breadCount
        newTemplate.insulin = shortInsulin
        newTemplate.name = templateName
        newTemplate.category = category
        for product in products {
            let newTemplateProduct = TemplateProduct(context: viewContext)
            newTemplateProduct.name = product.name
            newTemplateProduct.carbohydrates = product.carbs
            newTemplateProduct.fat = product.fat
            newTemplateProduct.id = UUID()
            newTemplateProduct.protein = product.protein
            newTemplateProduct.template = newTemplate
            newTemplate.addToTemplateProduct(newTemplateProduct)
        }
        saveContext()
    }

    func obtainCategoryFromTemplate(for word: String) -> String? {
        let templateFetchRequest = Templates.fetchRequest()
        templateFetchRequest.predicate = NSPredicate(format: "name == %@", word)

        do {
            let results = try viewContext.fetch(templateFetchRequest)
            if let productType = results.first {
            return productType.category
            }
        } catch {
            print("Ошибка при получении категории: \(error)")
        }

        return nil
    }
}
