//
//  coreDataController.swift
//  tableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 3/7/23.
//  CoreData management module

import Foundation
import CoreData
class coreDataController : ObservableObject
{
    @Published var cityData:[City] = [City()]
    
    let persistentContainer:NSPersistentContainer

       
     
    init()
    {
        //
        persistentContainer = NSPersistentContainer(name: "tableData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
                fatalError("cannot load data \(error.localizedDescription)")
            }
            
        }
        
        cityData = getCities()
        
    }
    
    func saveCity(cityName: String, cityPicture: String, cityDescription: String)
    {
        let city = City(context: persistentContainer.viewContext)
        city.name = cityName
        city.picture = cityPicture
        city.desc = cityDescription
        city.id = UUID()
        do {
            try persistentContainer.viewContext.save()
            cityData = getCities()
        } catch{
            print("failed to save \(error)")
        }
    }
    
    func deleteCity(city: City)
    {
        persistentContainer.viewContext.delete(city)
        do {
            try persistentContainer.viewContext.save()
        } catch{
            print("failed to save \(error)")
        }
        
    }
    func getCities() -> [City]
    {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let x = try persistentContainer.viewContext.fetch(fetchRequest)

            return x
        }catch{
            return []
        }
    }
    
    
}
    
    
    

