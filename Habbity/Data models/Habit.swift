//
//  Habit.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 10.04.2022.
//

import Foundation

struct Habit: Codable, Identifiable, Equatable {
    var id = UUID()
    
    let name: String
    let motivation: String
    
    var dailyCounter = 0
    let amountPerDay: Int
    
    let iconColor: String
    let iconName: String
    
    let reminder: Date

    
    static let example = Habit( name: "example", motivation: "your goal", dailyCounter: 0, amountPerDay: 1, iconColor: "mint", iconName: "book", reminder: Date.now)
}
