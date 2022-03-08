//
//  ContentView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            MainPage(habits: Habits())
                .tabItem {
                    Label("Habits", systemImage: "square.text.square")
                }
            
            SettingView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            
            //ADD PROGRESS VIEW
            
            //ADD IDEAS VIEW
            //JSON files with examples of Habits divided be groups. Think about remote handling of new ideas
        }
        .accentColor(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
