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
    
    @ObservedObject private var model = VisitFormViewModel()
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
                        
                        model.OrganizeVisits(price: priceOfVisit, date: dateOfVisit)
                        displayAlert = true
                    }.alert(isPresented: $displayAlert){
                        Alert(title: Text("Visit has been logged"),
                              message: Text("Your next visit reminder has been scheduled"))
                        
                    }
                }
            }.navigationBarTitle("Visit Information")
        }
    }
}

struct VisitFormView_Previews: PreviewProvider {
    static var previews: some View {
        VisitFormView()
    }
}
