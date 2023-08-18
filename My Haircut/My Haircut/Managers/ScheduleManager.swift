//
//  ScheduleManager.swift
//  My Haircut
//
//  Created by richard Haynes on 6/24/23.
//
// https://www.youtube.com/watch?v=mG9BVAs8AIo&t=1201s
import Foundation
struct ScheduleManager {
    
    enum ScheduleError : Error {
        case MissingVisitDate
    }
    
    private var numOfDaysSetting : Int
    private var timeSetting : Date
    
    init(){
        numOfDaysSetting = UserDefaults.standard.integer(forKey: "NumberOfDaysForNextNotificationSetting")
        timeSetting = UserDefaults.standard.object(forKey: "timeUserSetting") as? Date ?? Date()
    }
    
    init(numOfDaysSettings : Int, timeSettings : Date){
        self.numOfDaysSetting = numOfDaysSettings
        self.timeSetting = timeSettings
    }
    // MARK - Private Methods
    private func DetermineNextVisit(visit : Visit) throws -> DateComponents {
        var dateComponent = DateComponents()
        let currentCalendar = Calendar.current
        
        let hourFromUserDefaults = currentCalendar.component(.hour, from: timeSetting)
        let minuteFromUserDefaults = currentCalendar.component(.minute, from: timeSetting)
        guard let dateOfVisit = visit.dateOfVisit else {
            throw ScheduleError.MissingVisitDate
        }
        let currentCalendarDate = currentCalendar.date(byAdding: dateComponent, to: dateOfVisit)
        let futureDay = currentCalendar.component(.day, from: currentCalendarDate!) + numOfDaysSetting
        
        dateComponent.hour = hourFromUserDefaults
        dateComponent.minute = minuteFromUserDefaults
        dateComponent.day = futureDay
        return dateComponent
    }
    // MARK - Public Methods
    func ScheduleNextVisit(visit: Visit) throws {
        let scheduleDateComponents: DateComponents = try DetermineNextVisit(visit: visit)
        NotificationsManager.shared.scheduleNotifications(from: scheduleDateComponents)
        
    }
}


