//
//  Config-Template.swift
//  GithubFollowers
//
//  INSTRUCTIONS:
//  1. Copy this file and rename it to "Config.swift"
//  2. Replace "YOUR_GITHUB_TOKEN_HERE" with your actual GitHub Personal Access Token
//  3. Make sure Config.swift is added to .gitignore so it's not committed to version control
//

import Foundation

public struct Config {
    public static let githubToken = "YOUR_GITHUB_TOKEN_HERE"
    public static let baseURL = "https://api.github.com"
} 