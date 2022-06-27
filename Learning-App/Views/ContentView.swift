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
                    
                    ForEach(0 ..< lessons.count) { index in
                        
                        NavigationLink(destination: {
                            ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(index)
                                })
                        }, label: {
                            ContentViewRow(index: index)
                        })
                    }
                }
            }
                .accentColor(Color.black)
                .padding()
                .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
