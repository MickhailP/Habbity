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
            ZStack {
                if habits.items.isEmpty {
                    VStack {
                        Image("EmptyHabit")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                        Group {
                            Text("📄 You haven't any habits yet.")
                            Text("😃 Let's add a new one!")
                        }
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .font(.title3)
                        
                    }
                    .onTapGesture {showAddHabitView = true }
                    
                } else {
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
                }
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
