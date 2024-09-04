//
//  ChatListView.swift
//  TestOut5
//
//  Created by Brendan Sick on 9/4/24.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel = ChatListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .none:
                Text("Loading chats...")
            case .noResults:
                Text("No results found.")
            case .resultFound:
                List {
                    ForEach(viewModel.chats) { chat in
                        NavigationLink(value: chat.id) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(chat.topic ?? "New Chat") // Safely unwraps optional topic
                                        .font(.headline)
                                    Spacer()
                                    if let model = chat.model {  // Safely unwraps optional model
                                        Text(model.rawValue)
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(model.tintColor)
                                            .padding(6)
                                            .background(model.tintColor.opacity(0.1))
                                            .clipShape(Capsule(style: .continuous))
                                    }
                                    Text(chat.lastMessageTimeAgo)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteChat(chat: chat)
                                } label : {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Skills")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showProfile()
                } label: {
                    Image(systemName: "person")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.createChat()
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
//        .sheet(isPresented: $viewModel.isShowingProfileView) {
//            ProfileView()
//        }
//        .navigationDestination(for: String.self, destination: { chatId in
//            ChatView(viewModel: .init(chatId: chatId))
            
//        })
        .onAppear {
            if viewModel.loadingState == .none {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    ChatListView()
}
