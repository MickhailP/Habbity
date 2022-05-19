//
//  ContentView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var habitsViewModel = HabitsViewModel()
    
    var body: some View {
        TabView{
            
            HabitsView()
                .tabItem {
                    Label("Habits", systemImage: "square.text.square")
                }
            SamplesView()
                .tabItem {
                    Label("Inspiration", systemImage: "sparkles")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.vertical.3")
                }
            
            
            //ADD PROGRESS VIEW
            
            //ADD IDEAS VIEW
            //JSON files with examples of Habits divided be groups. Think about remote handling of new ideas
        }
        .accentColor(Color.green)
        .environmentObject(habitsViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
