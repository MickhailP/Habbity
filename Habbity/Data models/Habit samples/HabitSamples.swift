//
//  HabitSamples.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 26.04.2022.
//

import Foundation

struct HabitSampleGroup: Decodable {
    let health: [Habit]
    let family: [Habit]
    let selfDevelopment: [Habit]
}

//TEST DATA MODEL

struct SamplesGroup: Decodable, Identifiable {
    let id: Int
    let groupName: String
    let items: [Habit]
}
