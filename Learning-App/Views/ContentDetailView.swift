//
//  ContentDetailView.swift
//  Learning-App
//
//  Created by Grant Davis on 6/21/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.VideoHostURL + (lesson?.video ?? ""))
        
        VStack {
            // Video player
            if let url = url {
                VideoPlayer(player: AVPlayer(url: url))
                    .cornerRadius(10)
            }
            // TODO: Description
            CodeTestView()
            
            // Next lesson Button
            // Only show button if there is a next lesson
            if model.hasNextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    
                    ZStack {
                       
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
            // Show 'complete' button
            else {
                Button(action: {
                    
                    // Take the user back to the home view
                    model.currentContentSelected = nil
                }, label: {
                    
                    ZStack {
                       
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
        }
            .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
