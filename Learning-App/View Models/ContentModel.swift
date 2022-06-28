//
//  ContentModel.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    // Current module
    @Published var currentModule: Module?
    // Module index
    var currentModuleIndex = 0
    // Current lesson
    @Published var currentLesson: Lesson?
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    // Lesson index
    var currentLessonIndex = 0
    // Lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    // Current selected module
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        
        getLocalData()
    }
    
    
    // MARK: - Data Methods
    func getLocalData() {
        
        // Parse "data.json"
        // Get URL for "data" file
        if let URL = Bundle.main.url(forResource: "data", withExtension: "json") {
            
            // Read URL to Data object
            do {
               let data = try Data(contentsOf: URL)
                
                // Create JSON decoder
                let decoder = JSONDecoder()
                
                //Decode Data object with JSON decoder
                do {
                    self.modules = try decoder.decode([Module].self, from: data)
                }
                catch {
                    print(error)
                }
            }
            catch {
                print(error)
            }
        }
        
        // Parse "style.html"
        // Get URL for "style" file
        if let URL = Bundle.main.url(forResource: "style", withExtension: "html") {
            
            // Read URL to Data object
            do {
                styleData = try Data(contentsOf: URL)
                
                
            }
            catch {
                print(error)
            }
        }
    }
    
    // MARK: - Module Navigation Methods
    
    func beginModule(_ moduleid: Int) {
        
        // Find index for module id (loop through modules, compare id's, and get index of matching.
        currentModuleIndex = modules.firstIndex(where: {
            $0.id == moduleid
        })!
        
        // Set current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex: Int) {
        
        // Check that lesson index within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        // Set current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        // Advance lesson index
        currentLessonIndex += 1
        
        // Check that lesson index is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set current lesson
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            currentLesson = nil
            currentLessonIndex = 0
        }
        
    }
    
    func hasNextLesson() -> Bool {
        
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    func beginTest(_ moduleID: Int) {
        // Set current module
        beginModule(moduleID)
        
        // Set the current question
        currentQuestionIndex = 0
        // If there are some questions
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add styling data
        if let styleData = styleData {
            data.append(styleData)
        }
        
        // Add HTML data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html],
                                                          documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
}
