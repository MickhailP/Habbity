//
//  NoHabitsView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 12.04.2022.
//

import SwiftUI

struct NoHabitsView: View {
    //Connect with  AddHabitView to control when Big button will be tapped
    @Binding var showAddHabitView: Bool
    
    @State private var animate: Bool = false
    
    var body: some View {
        VStack {
            Image("EmptyHabit")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .shadow(color: .white.opacity(0.4), radius: 10, x: 0, y: 0)
            
            animatedAddButton
        }
    }
    
    
    var animatedAddButton: some View {
        Group {
            Text("📄 You've haven't any habits yet.")
                .padding(.bottom, 20)
            Text("😃 Add a new one!")
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(animate ? Color("blue") : Color.green)
                .cornerRadius(15)
                .padding(.horizontal, animate ? 50 : 60)
                .shadow(color: animate ? Color("blue").opacity(0.7) : Color.green.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 :40)
                .offset(y: animate ? -7 : 0)
                .onTapGesture { showAddHabitView = true }
                .onAppear(perform: addAnimation)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: 400)
        .foregroundColor(.primary)
        .font(.title3)
        
    }
    func addAnimation() {
        // If animated is "false" animation will not appear.
        guard !animate else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoHabitsView(showAddHabitView: .constant(false))
        }
        .previewInterfaceOrientation(.portrait)
    }
}
