//
//  MainTabView.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            VisitFormView(schedule: ScheduleManager()).tabItem(){
                Image(systemName: "scissors.badge.ellipsis")
                Text("Visit")
            }
            
            VisitHistoryView().tabItem(){
                Image(systemName:"clock.arrow.circlepath")
                Text("History")
            }
            SettingsView().tabItem(){
                Image(systemName: "gear")
                Text("Settings")
            }
        }.onAppear {
            NotificationsManager.shared.requestNotificationAuthorization()
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
