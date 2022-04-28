//
//  HabitsViewModel.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 05.12.2021.
//

import Foundation
import UserNotifications


@MainActor class HabitsViewModel: ObservableObject {
    
    @Published private (set) var habits: [Habit]
    
    @Published var showAddHabitView = false
    
    private let saveKey = "Habits"
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: saveKey){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habit].self, from: saved) {
                habits = decoded
                return
            }
        }
        habits = []
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(habits)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Failed to save data. ERROR: \(error.localizedDescription)")
        }
    }
    
    func addNew(_ habit: Habit) {
        habits.append(habit)
        addNotification(for: habit)
        save()
    }
    
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        save()
    }
    
    func update(habit: Habit) {
        if let index = habits.firstIndex(of: habit){
            habits[index] = habit
        }
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
