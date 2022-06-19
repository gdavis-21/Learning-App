//
//  HomeViewRow.swift
//  Learning-App
//
//  Created by Grant Davis on 6/19/22.
//

import SwiftUI

struct HomeViewRow: View {
    
    let image: String
    let title: String
    let description: String
    let count: String
    let time: String
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                
                // Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                // Text
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Headline
                    Text(title)
                        .font(.headline)
                    
                    // Description
                    Text(description)
                        .font(.caption)
                        .padding(.bottom, 20)
                    
                    // Icons
                    HStack {
                        
                        // Number of lessons/questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                        
                        Spacer()
                        
                        // Time requirement
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                    }
                    .font(.caption2)
                }
                .padding(.leading, 20)

            }
            .padding(.horizontal)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "Understand the fundamentals of the Swift programming language.", count: "10 Lessons", time: "3 Hours")
    }
}
