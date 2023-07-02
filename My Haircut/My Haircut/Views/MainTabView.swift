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
            VisitFormView().tabItem(){
                Image(systemName: "scissors.badge.ellipsis")
                Text("Visit")
            }
            
            VisitHistoryView().tabItem(){
                Image(systemName:"clock.arrow.circlepath")
                Text("History")
            }
            SettingsView().tabItem(){
                Image(systemName: "person")
                Text("Settings")
            }
        }.onAppear {
            NotificationsManager.shared.requestNotificationAuthorization()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
