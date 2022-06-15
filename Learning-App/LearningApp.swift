//
//  LearningApp.swift
//  Learning-App
//
//  Created by Grant Davis on 6/14/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
