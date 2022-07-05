//
//  TestView.swift
//  Learning-App
//
//  Created by Grant Davis on 6/27/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex = -1
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack(alignment: .leading) {
                // Question #
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // Question
                CodeTestView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            Button(action: {
                                selectedAnswerIndex = index
                            }, label: {
                                ZStack {
                                    
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    }
                                    else {
                                        // Answer has been submitted
                                        if selectedAnswerIndex == index && selectedAnswerIndex == model.currentQuestion!.correctIndex {
                                            // User has selected right answer
                                            // Show a green background
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }
                                        else if selectedAnswerIndex == index && selectedAnswerIndex != model.currentQuestion!.correctIndex {
                                            // Show a red background
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }
                                        else {
                                            RectangleCard(color: .white)
                                                .frame(height: 48)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                            })
                            .disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                // Button
                Button(action: {
                    
                    if submitted {
                        // The user tapped the button to move to the next question.
                        submitted = false
                        selectedAnswerIndex = -1
                        model.nextQuestion()
                    }
                    else {
                        // The user tapped the button to submit the answer.
                        submitted = true
                        
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                    
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        Text(buttonText)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding()
                })
                .disabled(selectedAnswerIndex == -1)
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            TestResultView(numCorrect: numCorrect)
        }
    }
    
    var buttonText: String {
        if submitted {
            if model.currentQuestionIndex == model.currentModule!.test.questions.count - 1 {
                // This is the last question
                return "Finish"
            }
            else {
                // There is another question
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
