//
//  ContentViewRow.swift
//  Learning-App
//
//  Created by Grant Davis on 6/19/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var lesson: Lesson
    
    var body: some View {
        
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30) {
                
                Text(String(lesson.id + 1))
                    .bold()
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                        .font(.caption)
                    
                }
            }
        }
    }
}


