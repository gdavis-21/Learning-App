//
//  ContentViewRow.swift
//  Learning-App
//
//  Created by Grant Davis on 6/19/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30) {
                
                Text(String(model.currentModule!.content.lessons[index].id + 1))
                    .bold()
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    
                    Text(model.currentModule!.content.lessons[index].title)
                        .bold()
                    Text(model.currentModule!.content.lessons[index].duration)
                        .font(.caption)
                }
            }
        }
    }
}


