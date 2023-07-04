//
//  VisitFormView.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//

import SwiftUI

struct VisitFormView: View {
    
    @State private var priceOfVisit: Double = 0
    @State private var dateOfVisit: Date = Date()
    @State private var displayAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @StateObject private var model : VisitFormViewModel
    
    init(schedule: ScheduleManager) {
        _model = StateObject(wrappedValue: VisitFormViewModel(schedule: schedule))
    }
    let formatter: NumberFormatter = {
            let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
            return currencyFormatter
        }()
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section{
                    DatePicker("Visited", selection: $dateOfVisit)
                } header: {
                    Text("Date Of Visit")
                }
                
                Section{
                    TextField("Price", value: $priceOfVisit, formatter: formatter)
                } header: {
                    Text("Price Of Visit")
                }
                
                Section {
                    Button("Save Visit"){
                        do {
                            try model.OrganizeVisits(price: priceOfVisit, date: dateOfVisit)
                            alertTitle = "Visit has been logged"
                            alertMessage = "Your next visit reminder has been scheduled"
                        }
                        catch VisitFormViewModel.VisitScheduleError.CantSchedule(let reasoning) {
                            alertTitle = "Next visit couldn't be scheduled something went wrong!"
                            alertMessage = reasoning
                        }
                        catch {
                            
                        }
                        displayAlert = true
                        // Resets the red badge icon over the app set during the notification creation
                        UIApplication.shared.applicationIconBadgeNumber = 0
                    }.alert(isPresented: $displayAlert){
                        Alert(title: Text(alertTitle),
                              message: Text(alertMessage))
                        
                    }
                }
            }.navigationBarTitle("Visit Information")
        }
    }
}


struct VisitFormView_Previews: PreviewProvider {
    static var previews: some View {
        VisitFormView(schedule: ScheduleManager())
    }
}
