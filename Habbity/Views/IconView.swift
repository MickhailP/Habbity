//
//  IconView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 29.11.2021.
//

import SwiftUI

struct IconView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var icon: Icon
    
    
    let columns = [ GridItem(.adaptive(minimum: 70)) ]
    
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 20){
            ForEach(Icon.names, id: \.self) { name in
                Image(systemName: name)
                    .foregroundColor(Color.gray)
                    .font(.title)
                    .onTapGesture {
                        icon.name = name
                        dismiss()
                    }
            }
        }
        .padding()
        
    }
}




struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(icon: Icon())
    }
}
