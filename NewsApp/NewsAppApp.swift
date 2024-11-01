//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Vidya Mulay on 26/10/24.
//

import SwiftUI
import CoreData

@main
struct NewsAppApp: App {
    let persistenceManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .environment(\.managedObjectContext, persistenceManager.persistentContainer.viewContext)
        }
    }
}
