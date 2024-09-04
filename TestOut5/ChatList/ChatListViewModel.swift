//
//  ChatListViewModel.swift
//  TestOut5
//
//  Created by Brendan Sick on 9/4/24.
//

import Foundation
import SwiftUI

class ChatListViewModel: ObservableObject {
    @Published var chats: [AppChat] = []
    @Published var loadingState: ChatListState = .none
    @Published var isShowingProfileView = false
    
    func fetchData() {
        self.chats = [
            AppChat(id: "1", topic: "Linear Algebra", model: .gpt3_5_turbo, lastMessageSent: Date(), owner: "123"),
            AppChat(id: "2", topic: "2-D arrays in Python", model: .gpt4, lastMessageSent: Date(), owner: "123")
        ]
        self.loadingState = .resultFound
    }
    func createChat() {
        
    }
    
    func showProfile() {
        isShowingProfileView = true
    }
    
    func deleteChat(chat: AppChat) {
        
    }
}

enum ChatListState {
    case loading
    case noResults
    case resultFound
    case none
}

struct AppChat: Codable, Identifiable {
    let id: String
    let topic: String?
    let model: ChatModel?
    let lastMessageSent: Date
    let owner: String
    
    var lastMessageTimeAgo: String {
        let now = Date()
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: lastMessageSent, to: now)

        let timeUnits: [(value: Int?, unit: String)] = [
            (components.year, "year"),
            (components.month, "month"),
            (components.day, "day"),
            (components.hour, "hour"),
            (components.minute, "minute"),
            (components.second, "second")
        ]

        for timeUnit in timeUnits {
            if let value = timeUnit.value, value > 0 {
                return "\(value) \(timeUnit.unit)\(value == 1 ? "" : "s") ago"
            }
        }

        return "just now"
    }
}

enum ChatModel: String, Codable, CaseIterable, Hashable {
    case gpt3_5_turbo = "GPT 3.5 Turbo"
    case gpt4 = "GPT 4"
    
    var tintColor : Color {
        switch self {
        case .gpt3_5_turbo:
            return .green
        case .gpt4:
            return .purple
        }
    }
}
