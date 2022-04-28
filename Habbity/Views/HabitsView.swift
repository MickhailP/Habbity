//
//  HabitsView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct HabitsView: View {
    
    
//    @Environment(\.colorScheme) var colorScheme
    
//    @State private var showAddHabitView = false
    
    @StateObject var viewModel = HabitsViewModel()
    
    
    var body: some View {
        NavigationView{
            ScrollView {
                ZStack {
                    if viewModel.habits.isEmpty {
                        NoHabitsView(showAddHabitView: $viewModel.showAddHabitView)
                            .transition(AnyTransition.opacity.animation(.easeInOut))
                        
                    } else {
                        VStack(spacing: 20){
                            ForEach(viewModel.habits, id: \.id){ habit in
                                
                                HabitRowView(habit: habit) { newHabit in
                                    viewModel.update(habit: newHabit)
    
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            .onDelete{ index in
                                Task { @MainActor in
                                    viewModel.deleteHabit(at: index)
                                }
                            }
//                            .listRowSeparator(.hidden)
                        }
                    }
                }
            
    //            .listStyle(PlainListStyle())
                .listStyle(.inset)
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
    //
                .sheet(isPresented: $viewModel.showAddHabitView) {
                    AddNewHabitView(viewModel: viewModel, icon: Icon())
            }
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView(viewModel: HabitsViewModel())
    }
}
