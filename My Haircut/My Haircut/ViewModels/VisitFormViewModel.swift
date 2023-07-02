//
//  VisitFormViewModel.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//

import Foundation
import SwiftUI
final class VisitFormViewModel: ObservableObject {
    private var context = PersistenceController.shared.container.viewContext
    private var schedule = ScheduleManager.shared
    // MARK - Public Methods
    func OrganizeVisits(price: Double, date: Date) {
        let visit = saveVisit(price: price, date: date)
        ScheduleNextVisit(visit: visit)
        // Resets the red badge icon over the app set during the notification creation
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func saveVisit(price: Double, date: Date)-> Visit{
        let visit = Visit(context: context)
        visit.dateOfVisit = date
        visit.price = price
        visit.id = UUID()

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return visit
    }
    
}
