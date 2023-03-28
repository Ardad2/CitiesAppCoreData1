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
    @State var isShowPhotoLibrary = false;
    
    @State  var data = ""
    
    @State var enterName = ""
    @State var enterPicture = ""
    @State var enterDescription = ""
    @State var enterImage = UIImage()
    
    var body: some View {
        NavigationView
        {
            
            List{
                ForEach(dataController.cityData) { datum in
                    if datum.name != nil
                    {
                        NavigationLink(destination:
                                        DetailView(picture: "Not avaliable for now", name: datum.name ?? "", description: datum.desc ?? ""))
                        {
                            if datum.name != nil
                            {
                                Image(uiImage: UIImage(data:(datum.picture ?? Data())) ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .edgesIgnoringSafeArea(.all)
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
                } .alert("Insert", isPresented: $toInsertView, actions: {

                    
                    TextField("Name:", text: $enterName)
                    TextField("Description:", text: $enterDescription)
                    TextField("Picture:", text: $enterPicture)

                    Button( action: {
                        isShowPhotoLibrary = true
                    })
                    {
                        
                        Label("Add Photo", systemImage: "plus")
                    }
                    
                    
                    Button("Insert", action: {
                        dataController.saveCity(cityName: enterName, cityPicture: enterImage.pngData() ?? Data(), cityDescription: enterDescription)
                        toInsertView = false
                        
                        
                        
                    })
                    
                    Button("Cancel", role: .cancel, action: {
                        toInsertView = false
                    })
                }, message: {
                    Text("Enter the details of the city you want to add.")
                }) .sheet(isPresented: $isShowPhotoLibrary, onDismiss: {toInsertView = true}) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$enterImage)
                }
            
            
        }
                         }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(dataController: coreDataController())
        }
    }
}
