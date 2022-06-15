//
//  ContentModel.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    init() {
        
        getLocalData()
    }
    
    func getLocalData() {
        
        // Parse "data.json"
        // Get URL for "data" file
        if let URL = Bundle.main.url(forResource: "data", withExtension: "json") {
            
            // Read URL to Data object
            do {
               let data = try Data(contentsOf: URL)
                
                // Create JSON decoder
                let decoder = JSONDecoder()
                
                //Decode Data object with JSON decoder
                do {
                    self.modules = try decoder.decode([Module].self, from: data)
                }
                catch {
                    print(error)
                }
            }
            catch {
                print(error)
            }
        }
        
        // Parse "style.html"
        // Get URL for "style" file
        if let URL = Bundle.main.url(forResource: "style", withExtension: "html") {
            
            // Read URL to Data object
            do {
                styleData = try Data(contentsOf: URL)
                
                
            }
            catch {
                print(error)
            }
        }
    }
}
