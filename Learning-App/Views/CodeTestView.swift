//
//  CodeTestView.swift
//  Learning-App
//
//  Created by Grant Davis on 6/22/22.
//

import SwiftUI

struct CodeTestView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        // Set attributed text for lesson
        textView.attributedText = model.codeText
        
        // Scroll back to top
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

//struct CodeTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        CodeTestView()
//            .en
//    }
//}
