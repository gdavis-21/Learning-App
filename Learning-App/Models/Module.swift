//
//  Module.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

struct Module: Identifiable, Decodable {
    
    var id: Int
    var category: String
    var content: Content
    var test: Test
    
}
