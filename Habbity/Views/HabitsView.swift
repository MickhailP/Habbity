//
//  HabitsView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct HabitsView: View {
    
    
//    @Environment(\.colorScheme) var colorScheme
    
    @State private var showAddHabitView = false
    
    @StateObject var viewModel = HabitsViewModel()
    
    
    var body: some View {
        
            ZStack {
                if viewModel.habits.isEmpty {
                    NoHabitsView(showAddHabitView: $showAddHabitView)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                    
                } else {
                    List{
                        ForEach(viewModel.habits, id: \.id){ habit in
                            
                            HabitRowView(habit: habit) { newHabit in
                                viewModel.update(habit: newHabit)
                            }
                        }
                        
                        .onDelete{ index in
                            Task { @MainActor in
                                viewModel.deleteHabit(at: index)
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
                AddNewHabitView(viewModel: viewModel, icon: Icon())
            }
        }
    
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView(viewModel: HabitsViewModel())
    }
}
