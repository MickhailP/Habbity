//
//  MainPage.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct MainPage: View {
    
    
//    @Environment(\.colorScheme) var colorScheme
    
    @State private var showAddHabitView = false
    
    @StateObject var habits = Habits()
    
    
    var body: some View {
        NavigationView {
            
            List{
                ForEach(habits.items, id: \.id){ habit in

                    HabitRowView(habit: habit) { newHabit in
                        habits.update(habit: newHabit)
                    }
                }
                
                .onDelete{ index in
                    Task { @MainActor in
                        habits.removeItems(at: index)
                    }
                }
                .listRowSeparator(.hidden)
            }
            
            .listStyle(PlainListStyle())
            .navigationBarTitle("My habits")
            .navigationBarItems(
                trailing:
                    Button(action:{
                        showAddHabitView = true
                    }) {
                        VStack{
                            Image(systemName: "plus.circle")
                            
                            Text("Add new habit")
                        }
                    })
            .sheet(isPresented: $showAddHabitView) {
                AddNewHabitView(habits: habits, icon: Icon())
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(habits: Habits())
    }
}
