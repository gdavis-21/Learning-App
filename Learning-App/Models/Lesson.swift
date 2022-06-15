//
//  Lesson.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

struct Lesson: Identifiable, Decodable {
    
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
}
