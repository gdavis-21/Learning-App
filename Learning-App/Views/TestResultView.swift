//
//  TestResultView.swift
//  Learning-App
//
//  Created by Grant Davis on 7/5/22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numCorrect: Int
    
    var body: some View {
        VStack {
            Text(resultHeading)
                .font(.title)
            Spacer()
            Text("You got \(numCorrect ?? 0) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            Button(action: {
                // Send the user back to the home screen.
                model.currentTestSelected = nil
            }, label: {
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding([.trailing, .leading])
            })
            Spacer()
        }
    }
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        if pct > 0.5 {
            return "Awesome!"
        }
        else if pct > 0.2 {
            return "Doing Great!"
        }
        else {
            return "Keep Learning."
        }
    }
}

//struct TestResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultView()
//    }
//}
