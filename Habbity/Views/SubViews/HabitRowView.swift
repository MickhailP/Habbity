//
//  HabitRowView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 10.04.2022.
//
// MARK: View description
//  View that present a instance of Habit on the HabitsView screen
//  Creates a rectangle card view
//  Track a Habit's daily counter


import SwiftUI

struct HabitRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var habit: Habit
    
    var onSave: (Habit) -> Void
    
    var body: some View {
        
        NavigationLink(destination: HabitDetailView(habit: habit) ) {
            ZStack {
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(colorScheme == .dark ? Color("dark") : .white)
                    
                
                HStack {
                    Image(systemName: habit.iconName)
                        .foregroundColor(Color(habit.iconColor))
                        .font(.title)
                        .padding(.trailing)
                    
                    VStack(alignment: .leading){
                        Text(habit.name)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text(habit.motivation)
                            .font(.subheadline)
                            .padding(.bottom, 5)
                        HStack {
                            Text("Daily goal:")
                                .font(.subheadline)
                            Text("\(habit.dailyCounter) / \(habit.amountPerDay)")
                                .font(.subheadline)
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        onSave( updateDailyCounter() )
                    }) {
                        Image(systemName: "checkmark.circle")
                    }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.blue)
                        .font(.system(size: 30))
                        .padding(.trailing, 30)
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
            }
            
      
        }
        .shadow(color: .black.opacity(0.1), radius: 15)
    }
         // Check it in the next time!
    func updateDailyCounter() -> Habit {
        var newHabit = habit
        newHabit.dailyCounter += 1
        habit = newHabit
        print(habit.dailyCounter)
        print(newHabit.dailyCounter)
        
        return newHabit
        
    }
    
    init(habit: Habit, onSave: @escaping (Habit) -> Void) {
        self.onSave = onSave
       _habit = State(wrappedValue: habit)
        
    }
}

struct HabitRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            List {
                HabitRowView(habit: Habit.example) { newHabit in }
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        }
    }
}
