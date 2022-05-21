//
//  HabitSamplesViewModel.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 18.05.2022.
//

import Foundation

extension SamplesView {
    class HabitSamplesViewModel: ObservableObject {
        
        //WOORKING VESRION
//        @Published private(set) var samples: HabitSampleGroup
        
        //TEST PROPERTY FOR COMPLEX JSON
        @Published private(set) var samplesGroups: [SamplesGroup]
        
        @Published var selectedSample: Habit?
//        @Published var showAddHabitView = false
        
        let resourceName = "HabitSamples.json"
        let testResource = "samples.json"
        
        //TEST INIT. Complex JSON data model.
        
        init() {
            if let url = Bundle.main.url(forResource: testResource, withExtension: nil) {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let decodedHabitSamples = try decoder.decode([SamplesGroup].self, from: data)
                    self.samplesGroups = decodedHabitSamples
                    return
                    
                } catch {
                    print("Failed to initialise while decoding HabitSamples. \(error.localizedDescription)")
                    print(error)
                }
            }
            self.samplesGroups = []
        }
        
        //MAIN INIT. WORKING VERSION
//        init() {
//            if let url = Bundle.main.url(forResource: resourceName, withExtension: nil) {
//                do {
//                    let data = try Data(contentsOf: url)
//                    let decoder = JSONDecoder()
//                    let decodedHabitSamples = try decoder.decode(HabitSampleGroup.self, from: data)
//                    self.samples = decodedHabitSamples
//                    return
//
//                } catch {
//                    print("Failed to initialise while decoding HabitSamples. \(error.localizedDescription)")
//                    print(error)
//                }
//            }
//            self.samples = HabitSampleGroup(health: [], family: [], selfDevelopment: [])
//        }
    }
}
