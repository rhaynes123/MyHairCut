//
//  ContentView.swift
//  My Haircut
//
//  Created by richard Haynes on 6/21/23.
//

import SwiftUI
import CoreData
import Charts

struct VisitHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Visit.dateOfVisit, ascending: true)],
        animation: .default)
    private var visits: FetchedResults<Visit>
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Spending By Week")
                Chart {
                    ForEach(visits) { visit in
                        LineMark(
                            x: .value("Week", visit.dateOfVisit!, unit: .day),
                            y: .value("Price", visit.price)
                        ).foregroundStyle(Color.red)
                    }
                }
                List {
                    ForEach(visits) { visit in
                        NavigationLink {
                            Text("Visit took place at \(visit.dateOfVisit!, formatter: dateFormatter)")
                        } label: {
                            let price = visit.price.formatted(.currency(code: "USD"))
                            Text(visit.dateOfVisit!, formatter: dateFormatter)
                            Text("\(price)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationBarTitle(Text("History of Visits"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { visits[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VisitHistoryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
