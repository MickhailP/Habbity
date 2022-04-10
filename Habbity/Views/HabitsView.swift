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
        NavigationView {
            ZStack {
                if viewModel.habits.isEmpty {
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
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView(viewModel: HabitsViewModel())
    }
}
