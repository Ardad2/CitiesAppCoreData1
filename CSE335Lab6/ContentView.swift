//
//  ContentView.swift
//  CSE335Lab6
//
//  Created by Arjun Dadhwal on 3/27/23.
//

import SwiftUI

struct section:Identifiable
{
    let id = UUID()
    let name: String
}

struct ContentView: View {
    
    //module that manage the coreData
    @State var dataController: coreDataController = coreDataController()

    // tableview sections
    @State  var sectionData = [
        section(name:"Programming Languages"),
        section(name:"Operating Systems"),
        section(name:"Mobile Platforms")]

    // boolean variable that enable show/hide data insert view
    @State var toInsertView = false
    
    /*variables to read data and the type (0: programming languages, 1: Operating systems, 2: Mobile platforms) to insert */
    @State  var data = ""
    @State  var type = ""
    //
   // @State var sectionType = ["Programming Languages", "Operating Systems", "Mobile Platforms"]
    
    var body: some View {
        NavigationView
        {
    
            List {
                    ForEach(dataController.LanData) { datum in
                        if datum.name != nil
                        {
                            NavigationLink(destination:
                                            DetailView(name: datum.name ?? ""))
                            {
                                if datum.name != nil
                                {
                                    Text(datum.name ?? "")
                                }
                            }
                        }
                    }.onDelete(perform: {IndexSet in
                        for index in IndexSet {
                            // call delete language method in coreData manager Module
                            let language = dataController.LanData[index]
                            dataController.deleteLanguage(lan: language)
                            }
                  
                        })
                    

            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Cities Visited")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                         
                            toInsertView = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }.alert("Insert", isPresented: $toInsertView, actions: {
                   
                    TextField("Enter City Name:", text: $data)

                    Button("Insert", action: {
                            dataController.saveLanguage(lanNam: data)
                            toInsertView = false
                          
                    
                        
                    })
                    Button("Cancel", role: .cancel, action: {
                        toInsertView = false
                    })
                }, message: {
                    Text("Enter the details of the city you want to add.")
                })
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataController: coreDataController())
    }
}
