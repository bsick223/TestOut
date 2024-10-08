//
//  OpenAiService.swift
//  TestOutV2
//
//  Created by Brendan Sick on 9/4/24.
//

import Foundation
import Alamofire

class OpenAiService {
    private let endPointURL = "https://api.openai.com/v1/chat/completions"
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
                                        // "gpt-3.5-turbo"
        let body = OpenAIChatBody(model: "gpt-4", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIApiKey)"
        ]
        
        return try? await AF.request(endPointURL, method: .post, parameters: body, encoder: .json,
                               headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
    
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
