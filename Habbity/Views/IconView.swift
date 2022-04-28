//
//  IconView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 29.11.2021.
//

import SwiftUI

struct IconView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var icon = Icon()
    
    var iconSelected: (String) -> Void
    
    let columns = [ GridItem(.adaptive(minimum: 70)) ]
    
    init (icon: Icon, iconSelected: @escaping (String) -> Void) {
        self.iconSelected = iconSelected
    }
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 20){
            ForEach(Icon.names, id: \.self) { name in
                Image(systemName: name)
                    .foregroundColor(Color.gray)
                    .font(.title)
                    .onTapGesture {
                        iconSelected(name)
                        dismiss()
                    }
            }
        }
        .padding()
        
    }
}




struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(icon: Icon()) { _ in }
    }
}
