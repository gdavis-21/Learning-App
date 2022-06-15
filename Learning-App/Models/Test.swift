//
//  Test.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

struct Test: Identifiable, Decodable {
    
    var id: Int
    var image: String
    var time: String
    var description: String
    var questions: [Question]
}
