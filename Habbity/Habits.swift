//
//  Habits.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 05.12.2021.
//

import Foundation
import UserNotifications

struct Habit: Codable, Identifiable, Equatable {
    var id = UUID()
    
    let name: String
    let motivation: String
    
    var dailyCounter = 0
    let amountPerDay: Int
    
    let iconColor: String
    var iconName: String
    
    var reminder: Date

    
    static let example = Habit( name: "example", motivation: "your goal", dailyCounter: 0, amountPerDay: 1, iconColor: "mint", iconName: "book", reminder: Date.now)

}


@MainActor class Habits: ObservableObject {
    
    @Published var items: [Habit]
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habit].self, from: saved) {
                items = decoded
                return
            }
        }
        items = []
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: "Items")
        } catch {
            print("Failed to save data. ERROR: \(error.localizedDescription)")
        }
    }
    
    func addNew(_ habit: Habit) {
        items.append(habit)
        addNotification(for: habit)
        save()
    }
    
    //add notification to our habit
    func addNotification(for habit: Habit) {

        let centre = UNUserNotificationCenter.current()
        
        let addRequest = {
            //create a body of notification
            let content = UNMutableNotificationContent()
            content.title = "Don't forget! \(habit.name)"
            content.subtitle = habit.motivation
            content.sound = UNNotificationSound.default
            
            //set when it will be shown
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: habit.reminder)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            //put altogether to request
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            centre.add(request)
        }
        
        // make sure we only schedule notifications when allowed
        centre.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                centre.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Failed to add notification. Notification isn't allowed! \(String(describing: error?.localizedDescription))")
                    }
                }
            }
        }
    }
}
