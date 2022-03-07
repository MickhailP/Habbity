//
//  Habits.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 05.12.2021.
//

import Foundation
struct Habit: Codable, Identifiable, Equatable {
    var id = UUID()
    
    let name: String
    let actionPlan: String
    
    var dailyCounter = 0
    let amountPerDay: Int
    
    let iconColor: String
    var iconName: String
    
    
    static let example = Habit( name: "example", actionPlan: "your goal", dailyCounter: 0, amountPerDay: 1, iconColor: "book", iconName: "book")

}


class Habits: ObservableObject {
    
    @Published var items: [Habit] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habit].self, from: saved) {
                items = decoded
                return
            }
        }
        items = []
    }
}
