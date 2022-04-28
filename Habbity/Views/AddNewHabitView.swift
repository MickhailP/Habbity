//
//  AddNewHabitView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI
import BottomSheet


struct AddNewHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: HabitsViewModel
    
    @StateObject var icon = Icon()
    
    
    @State private var name = ""
    @State private var motivation = ""
    @State private var amountPerDay = 1
    @State private var showIconView = false
    
    @State private var reminder = Date.now
    
    @State private var iconName = "book"
    @State private var iconColor = "heaven"
    
    
    //
    //Check that our form fully filled
    //
    var formFillingChecking: Bool {
        if name.isEmpty || motivation.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    //Icon selecting and Habit naming
                    //
                    Section(header: Text("Create your own habit")){
                        HStack {
                            Image(systemName: iconName)
                                .font(.system(size: 30))
                                .foregroundColor(Color(iconColor))
                                .padding(5)
                                .onTapGesture{
                                    showIconView = true
                                }
                            TextField("Habit name", text: $name)
                                .font(.title2)
                        }
                    }
                    
                    //Write Motivation and how much time per day do you want to make habits
                    //
                    Section {
                        TextField("What will motivate you?", text: $motivation)
                        
                        Stepper("\(amountPerDay) times a day", value: $amountPerDay, in: 1...20)
                    }
                    
                    //Choose reminder time with DatePicker
                    //
                    Section{
                        DatePicker("Select reminder time", selection: $reminder, displayedComponents: .hourAndMinute)
                    }
                    
                    // Color Selection
                    //
                    Section(header: Text("Select habit color")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Icon.colors, id: \.self) { color in
                                    
                                    ZStack{
                                        Circle()
                                            .fill(Color(color))
                                            .frame(width: 40, height: 40)
                                            .onTapGesture {
                                                iconColor = color
                                            }
                                            .padding(5)
                                        if iconColor == color {
                                            Circle()
                                                .stroke(Color(color), lineWidth: 2)
                                                .frame(width: 45, height: 45)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    //Select suggested habits
                    Section(header: Text("Or use suggested habits")){
                        
                    }
                }
                
                .navigationBarTitle("📝 Add a new habit")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            let habit = Habit(name: self.name, motivation: self.motivation, amountPerDay: self.amountPerDay, iconColor: self.iconColor, iconName: self.iconName, reminder: self.reminder)
                            
                            viewModel.addNew(habit)
                            dismiss()
                        } label: {
                            HStack {
                                Text("Save")
                                Image(systemName: "plus.circle")
                            }
                        }
                        .disabled(formFillingChecking)
                    }
                }
                
                
                //Here we call a bottom sheet with icons and dismiss it when user make choice
                .bottomSheet(
                    isPresented: $showIconView,
                    prefersGrabberVisible: true
                ) {
                    IconView(icon: icon) { selectedName in
                        iconName = selectedName
                    }
                }
                
            }
        }
    }
}


struct AddNewHabitView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddNewHabitView(viewModel: HabitsViewModel())
    }
}
