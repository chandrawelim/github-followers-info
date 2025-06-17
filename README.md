# GitHub Followers Info

A Swift iOS application for viewing GitHub user followers and repository information.

## Requirements

- Xcode 16
- iOS 18.0+
- Swift 5.0+

## Features

- Browse GitHub users and their followers
- View user profile information
- Display user repositories
- Clean, modern UI with snapshot testing
- Modular architecture with separation of concerns

## Configuration

This application requires a GitHub Personal Access Token to access the GitHub API.

### Setting up your GitHub Token

1. **Get a GitHub Personal Access Token**
   - Go to [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
   - Click "Generate new token"
   - Select the scopes you need (typically `public_repo` for public repositories)
   - Copy the generated token

2. **Configure the app**
   - Copy `Config-Template.swift` to `Config.swift`
   - Replace `"YOUR_GITHUB_TOKEN_HERE"` with your actual GitHub token
   - The `Config.swift` file is automatically ignored by git for security

3. **Example Config.swift**
   ```swift
   import Foundation

   public struct Config {
       public static let githubToken = "your_actual_github_token_here"
       public static let baseURL = "https://api.github.com"
   }
   ```

### Security Notes

- Never commit your actual GitHub token to version control
- The `Config.swift` file is excluded from git via `.gitignore`
- Use the `Config-Template.swift` as a reference for the expected structure

## Development

### Building the Project

1. Clone the repository
2. Configure your GitHub token (see Configuration section above)
3. Open `GithubFollowersApp.xcworkspace` in Xcode 16
4. Build and run the project

### Testing

The project includes unit tests and snapshot tests. To run tests:

1. Select the test target in Xcode
2. Press `Cmd+U` to run all tests

**Note**: This project was developed using Xcode 16. Snapshot test results may vary when using different Xcode versions or simulator configurations due to rendering differences.

### Architecture

The project follows a modular architecture with clear separation of concerns:

- **GithubFollowers**: Core business logic and API layer
- **GithubFollowersiOS**: UI components and view controllers
- **GithubFollowersApp**: App composition and dependency injection

### API Integration

The app integrates with the GitHub REST API to fetch:
- User follower lists
- User profile information
- User repository data

All API requests are authenticated using GitHub Personal Access Tokens.