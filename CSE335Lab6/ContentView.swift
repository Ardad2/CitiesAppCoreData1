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
    
    @State var dataController: coreDataController = coreDataController()

    @State var toInsertView = false
    
    @State  var data = ""
    @State  var type = ""
    
    var body: some View {
        NavigationView
        {
    
            List{
                    ForEach(dataController.cityData) { datum in
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
                            let city = dataController.cityData[index]
                            dataController.deleteCity(city: city)
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
                            dataController.saveCity(cityNam: data)
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
