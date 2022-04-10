//
//  HabitView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 06.12.2021.
//

import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    
    var body: some View {
        VStack {
            Text("Count \(habit.dailyCounter)")
            
//            Button("Add one") {
//                //      habit.dailyCounter += 1
//
//                var updatedHabit = habit
//                updatedHabit.dailyCounter += 1
//
//                if let index = habits.items.firstIndex(of: habit){
//                    habits.items[index] = updatedHabit
//                }
//            }
            
            Text("More features coming soon 😁")
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView( habit: .example)
    }
}
