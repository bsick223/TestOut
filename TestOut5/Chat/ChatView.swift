//
//  ChatView.swift
//  TestOutV2
//
//  Created by Brendan Sick on 9/3/24.
//

import SwiftUI
struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var isTyping = false // For "typing..." feature
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}),
                        id: \.id) { message in
                    messageView(message: message)
                }
                
                
            }
            
            HStack {
                TextField("Enter a message...", text:
                    $viewModel.currentInput)
                Button {
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                }
            }
        }
        .padding()
    }
    // To-DO use stream or typing.. feature
    func messageView(message: Message) -> some View {
        HStack{
            if message.role == .user { Spacer()}
            Text(message.content)
                .padding()
                .background(message.role == .user ? Color.blue:
                                Color.gray.opacity(0.2))
            if message.role == .assistant { Spacer()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
