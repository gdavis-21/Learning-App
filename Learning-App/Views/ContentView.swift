//
//  ContentView.swift
//  Learning-App
//
//  Created by Grant Davis on 6/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack(spacing: 20 ) {
                
                // Confirm that current module is set
                if let lessons = model.currentModule?.content.lessons {
                    
                    ForEach(lessons) { lesson in
                        
                        ContentViewRow(lesson: lesson)
                    }
                }
            }
                .padding()
                .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
