//
//  PokemonCoreData.swift
//  PokemonApp
//

import CoreData

@MainActor
class PokemonCoreData {
    /// Use Singleton pattern
    static let shared = PokemonCoreData()
    private init() {}
    
    /// Context data base
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /// Persistent container data base
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Error falied \(error) - \(error.userInfo)")
            }
        }
        return container
    }()
    
    /// Save context
    func saveContext() async throws {
        guard context.hasChanges else { return }
        do {
            try await context.perform { [self] in
                try  self.context.save()
            }
        } catch {
            throw error
        }
    }
    
    /// Fetch request
    func fetchRequest<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil) async throws -> [T] {
        let request = T.fetchRequest()
        request.predicate = predicate
        guard let typedRequest = request as? NSFetchRequest<T> else {
            fatalError("Error failed")
        }
        do {
            return try context.fetch(typedRequest)
        } catch {
            throw error
        }
    }
    
    /// Delete context
    func deleteContext(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    /// Clear entities
    func clearData() async throws {
        let entityNames = persistentContainer.managedObjectModel.entities.map { $0.name! }
        for entityName in entityNames {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch {
                throw error
            }
        }
    }
    
    /// Insert ManagedObject
    func insertManagedObject<T: NSManagedObject>(_ entity: T.Type) -> T {
        return T(context: context)
    }
}
