//
//  ScheduleManager.swift
//  My Haircut
//
//  Created by richard Haynes on 6/24/23.
//
// https://www.youtube.com/watch?v=mG9BVAs8AIo&t=1201s
import Foundation
struct ScheduleManager {
    static let shared = ScheduleManager()
}

private let numberOfDaysForNextNotification = 7
// MARK - Private Methods

private func DetermineNextVisit(visit : Visit) -> DateComponents {
    var dateComponent = DateComponents()
    let currentCalendar = Calendar.current
    
    let numOfDaysSetting = UserDefaults.standard.integer(forKey: "NumberOfDaysForNextNotificationSetting")
    let timeSetting = UserDefaults.standard.object(forKey: "timeUserSetting") as! Date
    
    
    let hourFromUserDefaults = currentCalendar.component(.hour, from: timeSetting)
    let minuteFromUserDefaults = currentCalendar.component(.minute, from: timeSetting)
    
    let dateOfVisit = visit.dateOfVisit!
    let currentCalendarDate = currentCalendar.date(byAdding: dateComponent, to: dateOfVisit)
    let futureDay = currentCalendar.component(.day, from: currentCalendarDate!) + numOfDaysSetting
    //dateComponent.day = 1
    dateComponent.hour = hourFromUserDefaults
    dateComponent.minute = minuteFromUserDefaults
    dateComponent.day = futureDay
    return dateComponent
}

func ScheduleNextVisit(visit: Visit) {
    let scheduleDateComponents: DateComponents = DetermineNextVisit(visit: visit)
    NotificationsManager.shared.scheduleNotifications(from: scheduleDateComponents)
}
