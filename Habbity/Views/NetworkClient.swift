//
//  NetworkClient.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 20.04.2022.
//

import SwiftUI
import Foundation


 class NetworkClient: ObservableObject {
    
    var data = Data()
    
    init(urlString: String) {
        guard let url = URL(string: urlString ) else {
            print("URL didn't converted from string")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data wasn't recognised")
                return
            }
            self.data = data
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }   
}
