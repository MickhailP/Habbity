//
//  MainPage.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct MainPage: View {
    
    @State private var showAddHabitView = false
    
    @ObservedObject var habits: Habits
    
    //    var habit: HabitItem
    
    var body: some View {
        NavigationView {
            
            List{
                ForEach(habits.items, id: \.id){ item in
                    HStack {
                        Circle()
                            .fill(Color(item.iconColor))
                            .frame(width: 30, height: 30)
                            .padding(.trailing)
                        
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                                .padding(.bottom, 5)
                            Text(item.actionPlan)
                                .font(.subheadline)
                                .padding(.bottom, 5)
                            HStack {
                                Text("Daily goal:")
                                    .font(.subheadline)
                                Text("\(item.dailyCounter) / \(item.amountPerDay)")
                                    .font(.subheadline)
                                NavigationLink("Look") {
                                    HabitView(habits: habits, habit: item)
                                }
                                
                            }
                            
                        }
                        Spacer()
                        
                        Button(action: {
                            //                                var counter = habits.items[item]
                            //                                counter.daily += 1
                            
                            //DAILY HABIT COUNTER
                            var updatedHabit = item
                            updatedHabit.dailyCounter += 1
                            
                            if let index = habits.items.firstIndex(of: item){
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
                .onDelete(perform: removeItems)
            }
            
            .navigationBarTitle("My habits")
            .navigationBarItems(trailing:
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
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(habits: Habits())
    }
}
