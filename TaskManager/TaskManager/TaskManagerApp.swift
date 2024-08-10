//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 09/08/2024.
//

import SwiftUI
import RealmSwift

@main
struct TaskManagerApp: SwiftUI.App {
    
    init() {
        // Configure Realm with migration
        let config = Realm.Configuration(
            schemaVersion: 2, // Increment this version number whenever you change the schema
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // Perform the migration: add 'order' property with a default value
                    migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                        newObject?["order"] = 0 // Default value for the new property
                    }
                }
            }
        )
        
        // Set the default Realm configuration
        Realm.Configuration.defaultConfiguration = config
        
        do {
            _ = try Realm() // This will trigger the migration if needed
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
