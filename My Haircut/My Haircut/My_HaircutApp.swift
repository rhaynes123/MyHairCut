//
//  My_HaircutApp.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//

import SwiftUI

@main
struct My_HaircutApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
