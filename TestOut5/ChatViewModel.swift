//
//  ChatViewModel.swift
//  TestOutV2
//
//  Created by Brendan Sick on 9/3/24.
//

import Foundation
extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: "“You are my study assistant. I’ll send you some content, and your job is to help me understand it better. Please create a test with three questions based on the content, asking one question at a time. Once I answer, provide my result along with feedback at the end.", createAt: Date() )]
        
        @Published var currentInput: String = ""
        private let openAIService = OpenAiService()
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
            Task {
                let response = await openAIService.sendMessage(messages: messages)
                guard let recieveOpenAIMessage = response?.choices.first?.message else {
                    print("Had no recieved message")
                    return
                }
                let recievedMessage = Message(id: UUID(), role: recieveOpenAIMessage.role, content: recieveOpenAIMessage.content, createAt: Date())
                await MainActor.run {
                    messages.append(recievedMessage)
                }
                
            }
        }
    }
}


struct Message: Decodable {
    
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
