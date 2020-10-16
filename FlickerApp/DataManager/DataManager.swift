// This class is used to save and retrieve data from persistance storage, File is being used for now but this can be extended fro keychaina and userdefaule or coreData if required

// PersistanceMethod
enum PersistanceMethod {
    case file
}


import Foundation

class DataManager {
    
    //Store data into persistance store
    func storeData<T: Codable>(data: T, for key: String, method: PersistanceMethod = .file){
        switch method {
        case .file:
            _ = store(data: data, for: key)
        }
    }
    
    
    //Get data from persistance store
    func getData<T: Codable>(for key: String, to type: T.Type, method: PersistanceMethod = .file) -> T? {
        switch method {
        case .file:
            return getData(from: key, for: type)
        }
    }
    
}


extension DataManager {
    
    //MARK: Storing * Retriving Methods
    //Method to be used to store data on disk
    private  func store<T: Codable>(data: T, for file: String) -> Bool {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                let dataToBeStored = try JSONEncoder().encode(data)
                try dataToBeStored.write(to: fileURL, options: .atomicWrite)
                return true
            }
            catch {
                return false
            }
        }
        return false
    }
    
    
    // Method to be used to retrive data from disk
    private  func getData<T: Codable>(from file: String, for type: T.Type) -> T? {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = dir.appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: fileURL, options: .mappedRead) else {return nil}
        
        guard let decodedModel = try? JSONDecoder().decode(T.self, from: data) else {return nil}
        
        return decodedModel
    }
    
}
