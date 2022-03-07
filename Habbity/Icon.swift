//
//  Icon.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 05.12.2021.
//

import Foundation

class Icon: ObservableObject{
    @Published var colors = ["green", "mint", "blue", "heaven", "lemon", "pink", "orange", "peach", ]
    
    @Published var names = ["book", "drop", "heart", "list.bullet.rectangle.portrait", "calendar.badge.clock", "bell", "flag", "bed.double", "lightbulb", "house", "bicycle", "figure.walk","face.smiling", "flame", "pawprint", "leaf", "cart", "alarm", "pills", "globe.americas", "brain.head.profile", "suitcase", "fork.knife", "checklist"]
    
    @Published var color = "gray"
    @Published var name = "book"
}
