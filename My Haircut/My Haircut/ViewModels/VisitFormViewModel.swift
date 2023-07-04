//
//  VisitFormViewModel.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//

import Foundation
import CoreData
final class VisitFormViewModel: ObservableObject {
    
    enum VisitScheduleError : Error {
        case CantSchedule(reasoning: String)
    }
    
    private var context = PersistenceController.shared.container.viewContext
    private var schedule : ScheduleManager
    
    init( schedule: ScheduleManager) {
        self.context = PersistenceController.shared.container.viewContext
        self.schedule = schedule
    }
    
    // MARK - Public Methods
    func OrganizeVisits(price: Double, date: Date) throws {
        do {
            let visit = saveVisit(price: price, date: date)
            try schedule.ScheduleNextVisit(visit: visit)
        }
        catch ScheduleManager.ScheduleError.MissingVisitDate {
            throw VisitScheduleError.CantSchedule(reasoning: "Visit Date Missing")
        }
        catch {
            
        }
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
