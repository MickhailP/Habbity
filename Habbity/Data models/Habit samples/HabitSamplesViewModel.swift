//
//  HabitSamplesViewModel.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 18.05.2022.
//

import Foundation

class HabitSamplesViewModel: ObservableObject {
 
    @Published private(set) var samples: HabitSamples
    
    
    init() {
        if let url = Bundle.main.url(forResource: "HabitSamples.json", withExtension: nil) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedHabitSamples = try decoder.decode(HabitSamples.self, from: data)
                self.samples = decodedHabitSamples
                
            } catch {
                print("Failed to initialise while decoding HabitSamples. \(error.localizedDescription)")
               
            }
        }
        self.samples = HabitSamples(health: [])
    }
}

