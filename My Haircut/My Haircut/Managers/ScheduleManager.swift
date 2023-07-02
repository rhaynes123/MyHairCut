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
    let numOfDaysSetting = UserDefaults.standard.integer(forKey: "NumberOfDaysForNextNotificationSetting")
    let timeSetting = UserDefaults.standard.object(forKey: "timeUserSetting") as! Date
    
    let currentCalendar = Calendar.current
    let hourFromUserDefaults = currentCalendar.component(.hour, from: timeSetting)
    let minuteFromUserDefaults = currentCalendar.component(.minute, from: timeSetting)
    
    let dateOfVisit = visit.dateOfVisit!
    var dateComponent = DateComponents()
    //dateComponent.day = 1
    dateComponent.hour = hourFromUserDefaults
    dateComponent.minute = minuteFromUserDefaults
    return dateComponent
}

func ScheduleNextVisit(visit: Visit) {
    let scheduleDateComponents: DateComponents = DetermineNextVisit(visit: visit)
    NotificationsManager.shared.scheduleNotifications(from: scheduleDateComponents)
}
