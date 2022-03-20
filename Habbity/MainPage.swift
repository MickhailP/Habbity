//
//  MainPage.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct MainPage: View {
    @Environment(\.colorScheme) var colorScheme

    
    @State private var showAddHabitView = false
    
    @ObservedObject var habits: Habits
    
    //    var habit: HabitItem
    
    var body: some View {
        NavigationView {
            
            List{
                ForEach(habits.items, id: \.id){ habit in
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(colorScheme == .dark ? Color("dark") : .white)
                                .shadow(color: .black.opacity(0.3), radius: 5)
                            
                            NavigationLink(destination: HabitView(habits: habits, habit: habit) ){
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
                                
                                Spacer()
                                
                                Button(action: {
                                    //DAILY HABIT COUNTER
                                    var updatedHabit = habit
                                    updatedHabit.dailyCounter += 1
                                    
                                    if let index = habits.items.firstIndex(of: habit){
                                        habits.items[index] = updatedHabit
                                    }
                                }) {
                                    Image(systemName: "checkmark.circle")
                                }
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(Color.blue)
                                .font(.system(size: 30))
                                .padding(.trailing, 30)
                                
                            }
                        }
                            .padding()
                        
                    }
                        
                }
                
                .onDelete{ _ in 
                    Task { @MainActor in
                        habits.removeItems
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
