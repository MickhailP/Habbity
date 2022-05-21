//
//  HabitView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 06.12.2021.
//

import SwiftUI


enum KittenImageLocation: String {
        case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
        case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
        case error = "not a url"
    }

struct HabitDetailView: View {
    var habit: Habit
//    let imageLocation = KittenImageLocation.http.rawValue
    
    @StateObject private var networkClient = NetworkClient(urlString: KittenImageLocation.https.rawValue)
    
    var image: Image? {
        
        if let uiImage = UIImage(data: networkClient.data)  {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Count \(habit.dailyCounter)")
                
               image
              
                }
                .padding(20)
    
                
                Text("More features coming soon 😁")
            }
        }
    }
    
//    func loadImage() -> Image {
//        let image: Image
//
//
//    }
    


struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView( habit: .example)
    }
}
