//
//  SettingsView.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//
/*
 https://sarunw.com/posts/swiftui-picker-enum/
 https://daddycoding.com/2019/12/18/swiftui-datepicker-timepicker/
 */
import SwiftUI

struct SettingsView: View {
    @State private var currentDate : Date = UserDefaults.standard.object(forKey: "timeUserSetting") as? Date ?? Date()
    @State private var NumberOfDaysForNextNotification : Int = UserDefaults.standard.integer(forKey: "NumberOfDaysForNextNotificationSetting")
    @State private var displayAlert = false
    let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
        formatter.numberStyle = .none
            return formatter
        }()
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    DatePicker("Time", selection: $currentDate, displayedComponents: .hourAndMinute)
                } header: {
                    Text("Time of Day")
                }
                
                Section {
                    TextField("Number of Days", value: $NumberOfDaysForNextNotification, formatter: numberFormatter)
                } header: {
                    Text("Number of Days Between Visit")
                }
                
                Section {
                    Button("Save User Settings"){
                        UserDefaults.standard.set(currentDate, forKey: "timeUserSetting")
                        UserDefaults.standard.set(NumberOfDaysForNextNotification, forKey: "NumberOfDaysForNextNotificationSetting")
                        displayAlert = true
                    }.alert(isPresented: $displayAlert){
                        Alert(title: Text("Settings Saved"))
                        
                    }
                }
                
            }.navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
