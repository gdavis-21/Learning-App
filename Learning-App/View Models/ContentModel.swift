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
        
        // Parse local, append to modules
        getLocalData()
        
        // Parse remote, append to modules
        getRemoteData()
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
    
    func getRemoteData() {
        
        // Path
        let stringURL = "https://gdavis-21.github.io/Learning-App-Demo-Data/data2.json"
        
        // Create URL object
        let url = URL(string: stringURL)
        
        guard url != nil else {
            return
        }
        
        // Create URLRequest object
        let request = URLRequest(url: url!)
        
        // Get session and kick on request
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            // Check if there's an error
            guard error == nil else {
                // There was an error
                return
            }
            // Handle response
            let decoder = JSONDecoder()
            
            do {
                let modules = try decoder.decode([Module].self, from: data!)
                
                self.modules += modules
            }
            catch {
                print("Unable to parse JSON")
            }
        }
        
        dataTask.resume()
        
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
    
    func nextQuestion() {
        
        // Advance question index (move to next question)
        currentQuestionIndex += 1
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            codeText = addStyling(currentModule!.test.questions[currentQuestionIndex].content)
        }
        else {
            currentQuestion = nil
            currentQuestionIndex = 0
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
