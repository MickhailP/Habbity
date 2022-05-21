//
//  HabitsView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct HabitsView: View {
    
    
//    @State private var showAddHabitView = false
    
//    @StateObject var viewModel = HabitsViewModel()
    @EnvironmentObject var viewModel: HabitsViewModel
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.habits.isEmpty {
                    NoHabitsView(showAddHabitView: $viewModel.showAddHabitView)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                    
                } else {
                    
                    List(viewModel.habits) { habit in
                        
                        HabitRowView(habit: habit) { newHabit in
                            viewModel.update(habit: newHabit)
                            
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                    
//                    List{
//                        ForEach(viewModel.habits, id: \.id){ habit in
//
//                            HabitRowView(habit: habit) { newHabit in
//                                viewModel.update(habit: newHabit)
//                            }
//                            .padding(.vertical, 5)
//                        }
//
//                        .onDelete{ index in
//                            Task { @MainActor in
//                                viewModel.deleteHabit(at: index)
//                            }
//                        }
//                        .listRowSeparator(.hidden)
//                    }
//                    .listStyle(.plain)
                }
            }
            
            
            
           
//            .listStyle(.inset)
            .navigationBarTitle("My habits")
            .toolbar {
                Button(action:{
                    viewModel.showAddHabitView = true
                }) {
                    VStack{
                        Image(systemName: "plus.circle")
                        Text("Add new habit")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddHabitView) {
                AddNewHabitView()
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
            
    }
}
