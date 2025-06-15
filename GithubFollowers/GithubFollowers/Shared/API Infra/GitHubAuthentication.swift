//
//  GitHubAuthentication.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation

public struct GitHubAuthentication {
    public static let token = "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"
    
    public static func addAuthHeaders(to request: inout URLRequest) {
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
    }
    
    public static func authenticatedRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        addAuthHeaders(to: &request)
        return request
    }
} 
