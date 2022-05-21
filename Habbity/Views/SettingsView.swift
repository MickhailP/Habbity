//
//  SettingsView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 21.11.2021.
//

import SwiftUI

struct SettingsView: View {
    init() { UITableView.appearance().backgroundColor = UIColor.clear }
    
    @State private var showConnectionAlert = false
    
    
    var body: some View {
        NavigationView {
            List{
                Section {
                    HStack {
                        VStack(alignment: .leading){
                            Text("Upgrade to")
                            Text("PRO version")
                                .font(.title3)
                                .bold()
                        }
                        .foregroundColor(.white)
                        Spacer()
                        
                        Text("👑")
                            .font(.largeTitle)
                    }
                    .padding(.vertical, 20)
                }
                .listRowBackground(LinearGradient(colors: [Color("Purple"), Color("LightPurple")], startPoint: .leading, endPoint: .trailing))
//                .shadow(color: .gray, radius: 10)
                
                Section("Share") {
                    HStack {
                        Link("✨ Follow on Twitter", destination: URL(string: "https://twitter.com/Mikhail_Pv")!)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                    Button(action: shareButton) {
                        HStack{
                            Text("👍🏻 Recommend App")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }
                }
                
                Section("Feedback") {
                    Button(action: {showConnectionAlert = true}) {
                        HStack{
                            Text("🧵 Connect with us")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }
                    
                    HStack {
                        Link("🪲 Report a bug", destination: URL(string: "mailto:mich_p@inbox.ru")!)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                    Button(action: {showConnectionAlert = true}) {
                        HStack{
                            Text("✅ Suggest a new feature")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                     }
                }
                
                
                Section("Policy") {
                    Text(" Terms of Use")
                    Text(" Privacy policy")
                }
            }
            .navigationTitle("Settings")
            .shadow(color: .gray.opacity(0.6), radius: 15)
            .listStyle(.insetGrouped)
            
            //                Group{
            //                    Text("ver. 0.3")
            //                    Text("Habbity")
            //                }
            //                .font(.subheadline)
            //                .foregroundColor(.secondary)
            //
            
            .confirmationDialog("Connect with us", isPresented: $showConnectionAlert, actions: {
                Link("Telegram", destination: URL(string: "https://t.me/mikh_pv")!)
                Link("Instagram", destination: URL(string: "https://www.instagram.com/mih_pv")!)
            })
        }
    }
    
    func shareButton() {
        let url = URL(string: "https://appstore.com")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
