import Foundation
import CoreData

class DataBaseManager {
    
    static var share = DataBaseManager()
    var managedContext = appDelegate?.persistentContainer.viewContext
    var savedCities: [CitiesWeather]? {
        get {
            return getData()
        }
    }

    private func getData() -> [CitiesWeather]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CitiesWeather")
        
        do {
            return try managedContext?.fetch(request) as? [CitiesWeather]
        } catch {
            print("Error with getting Data…")
            return nil
        }
    }
    
    func saveContext(cityName: String) {
        guard let manageContext = managedContext else { return }
        let cityWeather = CitiesWeather(context: manageContext)
        cityWeather.city = cityName
        saveContext()
    }
    
    func existsInDataBase(name: String) -> Bool {
        var counter: Int = 0
        for city in savedCities! {
            if name == city.city {
                counter += 1
            }
        }
        
        return counter > 0
    }
    
    func saveContext() {
        do {
            try self.managedContext?.save()
            print("SAVED SAVED SAVED!")
        } catch {
           print("Oops, it's error with saving!")
        }
    }
    
    func delete(city: CitiesWeather) {
        managedContext?.delete(city)
        saveContext()
    }
    
    
}
