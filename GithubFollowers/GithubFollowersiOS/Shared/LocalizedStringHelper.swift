//
//  LocalizedStringHelper.swift
//  GithubFollowersiOS
//
//  Created by System on 25/06/25.
//

import Foundation

public final class LocalizedStringHelper {
    private init() {}
    
    private static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
}

// MARK: - Shared UI Strings
public extension LocalizedStringHelper {
    static var errorTitle: String {
        NSLocalizedString("error_title",
                          tableName: "Shared",
                          bundle: bundle, comment: "Error title")
    }
    
    static var okButton: String {
        NSLocalizedString("ok_button",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "OK button text")
    }
    
    static var okButtonLowercase: String {
        NSLocalizedString("ok_button_lowercase",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "OK button text in lowercase")
    }
    
    static var somethingWentWrong: String {
        NSLocalizedString("something_went_wrong",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Generic error message when something goes wrong")
    }
    
    static var unableToCompleteRequest: String {
        NSLocalizedString("unable_to_complete_request",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Error message when unable to complete a request")
    }
    
    static var noLocation: String {
        NSLocalizedString("no_location",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Text displayed when user has no location set")
    }
    
    static var noBio: String {
        NSLocalizedString("no_bio",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Text displayed when user has no bio")
    }
    
    static var unknown: String {
        NSLocalizedString("unknown",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Text displayed for unknown values")
    }
    
    static var noDescriptionAvailable: String {
        NSLocalizedString("no_description_available",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Text displayed when repository has no description")
    }
    
    static var githubProfile: String {
        NSLocalizedString("github_profile",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Button text to view GitHub profile")
    }
    
    static var followers: String {
        NSLocalizedString("followers",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Label for followers count")
    }
    
    static var following: String {
        NSLocalizedString("following",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Label for following count")
    }
    
    static var invalidURL: String {
        NSLocalizedString("invalid_url",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Error title for invalid URL")
    }
    
    static var invalidURLMessage: String {
        NSLocalizedString("invalid_url_message",
                          tableName: "Shared",
                          bundle: bundle,
                          comment: "Error message when URL is invalid")
    }
}

// MARK: - Search UI Strings
public extension LocalizedStringHelper {
    static var getFollowers: String {
        NSLocalizedString("get_followers",
                          tableName: "Search",
                          bundle: bundle,
                          comment: "Button text to get followers")
    }
    
    static var emptyUsername: String {
        NSLocalizedString("empty_username",
                          tableName: "Search",
                          bundle: bundle,
                          comment: "Error title when username field is empty")
    }
    
    static var pleaseEnterUsername: String {
        NSLocalizedString("please_enter_username",
                          tableName: "Search",
                          bundle: bundle,
                          comment: "Error message asking user to enter a username")
    }
    
    static var enterUsernamePlaceholder: String {
        NSLocalizedString("enter_username_placeholder",
                          tableName: "Search",
                          bundle: bundle,
                          comment: "Placeholder text for username input field")
    }
}

// MARK: - Repository UI Strings
public extension LocalizedStringHelper {
    static var repositories: String {
        NSLocalizedString("repositories",
                          tableName: "Repository",
                          bundle: bundle,
                          comment: "Header text for repositories section")
    }
} 
