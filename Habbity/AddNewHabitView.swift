//
//  AddNewHabitView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI


struct AddNewHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var habits = Habits()
    @StateObject var icon = Icon()
    
    //    let habit: HabitItem
    //    let habits: Habits
    
    @State private var name = ""
    @State private var actionPlan = ""
    @State private var amountPerDay = 1
    @State private var showIconView = false
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("Create your own habit")){
                        HStack {
                            Image(systemName: icon.name)
                                .font(.system(size: 30))
                                .foregroundColor(Color(icon.color))
                                .padding(5)
                                .onTapGesture{
                                    showIconView = true
                                }
                            TextField("Habit name", text: $name)
                                .font(.title2)
                        }
                    }
                    .foregroundColor(.black)
                    
                    Section {
                        TextField("Your action plan", text: $actionPlan)
                        
                        Stepper("\(amountPerDay) times a day", value: $amountPerDay, in: 1...20)
                    }
                    
                    Section(header: Text("Select habit color")) {
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(icon.colors, id: \.self) { color in
                                ZStack{
                                    Circle()
                                        .fill(Color(color))
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            icon.color = color
                                            
                                        }
                                        .padding(5)
                                    if icon.color == color {
                                        Circle()
                                            .stroke(Color(color), lineWidth: 2)
                                            .frame(width: 37, height: 35)
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.black)
                    
                    Section(header: Text("Or use suggested habits")){
                        
                    }
                }
                
                .navigationBarTitle("Add new habit")
                .navigationBarItems(
                    
                    trailing: Button(action: {
                        let habit = Habit(name: self.name, actionPlan: self.actionPlan, amountPerDay: self.amountPerDay, iconColor: icon.color, iconName: icon.name)
                        
                        self.habits.items.append(habit)
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }){
                        
                        HStack {
                            Text("Save")
                            Image(systemName: "plus.circle")
                        }
                    })
                .sheet(isPresented: $showIconView ){
                    IconView(icon: icon)
                }
            }
        }
    }
}


struct AddNewHabitView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddNewHabitView(habits: Habits(), icon: Icon())
    }
}
