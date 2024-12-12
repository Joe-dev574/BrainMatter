//
//  BrainMatterApp.swift
//  BrainMatter
//
//  Created by Joseph DeWeese on 12/10/24.
//

import SwiftUI
import SwiftData

@main
struct BrainMatterApp: App {
    init() {
        let schema = Schema([Item.self])
        let config = ModelConfiguration("BrainMatter", schema: schema)
        do {
            brainBucket = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure your brain bucket: \(error)")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    let brainBucket: ModelContainer
    var body: some Scene {
        WindowGroup {
            ItemListScreen()
        }
        .modelContainer(brainBucket)
    }
    }

