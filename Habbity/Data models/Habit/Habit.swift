//
//  Habit.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 10.04.2022.
//

import Foundation

struct Habit: Codable, Identifiable, Equatable {
    
    //Set up our properties
    var id = UUID()
    
    let name: String
    let motivation: String
    
    var dailyCounter = 0
    let amountPerDay: Int
    
    let iconColor: String
    let iconName: String
    
    let reminder: Date
    
    //Set up CodingKeys that allow us to match a JSON keys
    enum CodingKeys: CodingKey {
        case id, name, motivation, dailyCounter, amountPerDay, iconColor, iconName, reminder
    }
    
    //Write a custom initialiser because we need to create Habit instance manually as well
    init(name: String, motivation: String, amountPerDay: Int, iconColor: String, iconName: String, reminder: Date) {
        self.id = UUID()
        self.name = name
        self.motivation = motivation
        self.dailyCounter = 0
        self.amountPerDay = amountPerDay
        self.iconColor = iconColor
        self.iconName = iconName
        self.reminder = reminder
    }
    
    //Custom decoding logic. It's necessary because HabitSamples doesn't provide date for reminder property
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.motivation = try container.decode(String.self, forKey: .motivation)
        self.dailyCounter = try container.decode(Int.self, forKey: .dailyCounter)
        self.amountPerDay = try container.decode(Int.self, forKey: .amountPerDay)
        self.iconColor = try container.decode(String.self, forKey: .iconColor)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.reminder = try container.decodeIfPresent(Date.self, forKey: .reminder) ?? Date.now
    }

    
    static let example = Habit( name: "example", motivation: "your goal", amountPerDay: 1, iconColor: "mint", iconName: "book", reminder: Date.now)
}
