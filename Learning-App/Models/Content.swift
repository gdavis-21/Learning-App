//
//  Content.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

struct Content: Identifiable, Decodable {
    
    var id: Int
    var image: String
    var time: String
    var description: String
    var lessons: [Lesson]
}
