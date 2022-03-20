//
//  AddNewHabitView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI


struct AddNewHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    var habit = Habit.example
    @StateObject var habits = Habits()
    @StateObject var icon = Icon()
    
    
    //    let habit: HabitItem
    //    let habits: Habits
    
    @State private var name = ""
    @State private var motivation = ""
    @State private var amountPerDay = 1
    @State private var showIconView = false
    
    @State private var reminder = Date.now
    
    var formFillingCheck: Bool {
        if name.isEmpty || motivation.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    //Icon selecting and Habit naming
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
                    
                    //Write Motivation and how much time per day do you want to make habits
                    Section {
                        TextField("What will motivate you?", text: $motivation)
                        
                        Stepper("\(amountPerDay) times a day", value: $amountPerDay, in: 1...20)
                    }
                    
                    //Choose reminder time with DatePicker
                    Section{
                        DatePicker("Select reminder time", selection: $reminder, displayedComponents: .hourAndMinute)
                    }
                    
                    // Color Selection
                    Section(header: Text("Select habit color")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(icon.colors, id: \.self) { color in
                                    
                                    ZStack{
                                        Circle()
                                            .fill(Color(color))
                                            .frame(width: 40, height: 40)
                                            .onTapGesture {
                                                icon.color = color
                                                
                                            }
                                            .padding(5)
                                        if icon.color == color {
                                            Circle()
                                                .stroke(Color(color), lineWidth: 2)
                                                .frame(width: 45, height: 45)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.black)
                    
                    //Select suggested habits
                    Section(header: Text("Or use suggested habits")){
                        
                    }
                }
                
                .navigationBarTitle("Add new habit")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            let habit = Habit(name: self.name, motivation: self.motivation, amountPerDay: self.amountPerDay, iconColor: icon.color, iconName: icon.name, reminder: self.reminder)
                            
                            
                            habits.addNew(habit)
                            dismiss()
                        } label: {
                            HStack {
                                Text("Save")
                                Image(systemName: "plus.circle")
                            }
                        }
                        .disabled(formFillingCheck)
                    }
                    
                }
                
                
                .sheet(isPresented: $showIconView){
                    IconView(icon: icon, habit: habit)
                }
            }
        }
    }
}


struct AddNewHabitView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddNewHabitView(habits: Habits())
    }
}
