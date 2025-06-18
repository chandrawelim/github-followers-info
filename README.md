# GitHub Followers Info

[![iOS](https://img.shields.io/badge/iOS-18.0+-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org/)
[![Xcode](https://img.shields.io/badge/Xcode-16+-blue.svg)](https://developer.apple.com/xcode/)

A modern, scalable Swift iOS application for exploring GitHub users, their followers, and repository information. Built with clean architecture principles and comprehensive test coverage.

## 🎯 Overview

GitHub Followers Info demonstrates modern iOS development practices including:
- **Clean Architecture** with modular design
- **Reactive Programming** using Combine framework
- **Comprehensive Testing** with unit tests and snapshot tests
- **Accessibility Support** with Dynamic Type and localization
- **Modern UI** with UIKit and programmatic layouts

## 📱 Screenshots

<div align="center">
  <img src="screenshots/search_screen.png" width="200" alt="Search Screen" />
  <img src="screenshots/followers_list.png" width="200" alt="Followers List" />
  <img src="screenshots/user_profile.png" width="200" alt="User Profile" />
  <img src="screenshots/github_profile.png" width="200" alt="GitHub Profile" />
</div>

*From left to right: Search Screen, Followers List, User Profile with Repositories, GitHub Profile Integration*

## ✨ Features

### Core Functionality
- 🔍 **User Search**: Search for GitHub users with input validation
- 👥 **Followers Browser**: Browse user followers
- 📊 **User Profiles**: Comprehensive user information display
- 📚 **Repository Listing**: View user's public repositories with filtering
- 🌐 **GitHub Integration**: Seamless Safari integration for complete profiles

### User Experience
- 🎨 **Modern UI**: Clean, minimalist design with smooth animations
- ♿ **Accessibility**: Full Dynamic Type support and localization
- 📱 **Responsive**: Optimized for all iPhone screen sizes
- 🌙 **Dark Mode**: Native dark/light mode support
- ⚡ **Performance**: Efficient image caching and data loading

## 🛠 Tech Stack

### Frameworks & Technologies
- **UIKit** - Native iOS UI framework
- **Combine** - Reactive programming and data binding
- **Foundation** - Core system services and utilities
- **SafariServices** - In-app web browsing
- **XCTest** - Unit testing framework

### Architecture & Patterns
- **Clean Architecture** - Separation of concerns with distinct layers
- **MVP Pattern** - Model-View-Presenter for UI logic
- **Dependency Injection** - Loose coupling and testability
- **Repository Pattern** - Data access abstraction
- **Composition Root** - Centralized object graph composition

### Key Components
- **Modular Design**: Separated into distinct frameworks
  - `GithubFollowers` - Core business logic and API layer
  - `GithubFollowersiOS` - UI components and view controllers
  - `GithubFollowersApp` - App composition and dependency injection

### Data & Networking
- **URLSession** - Native HTTP networking
- **JSON Decoding** - Codable protocol for API responses
- **Authentication** - GitHub Personal Access Token integration
- **Error Handling** - Comprehensive error management

### Testing
- **Unit Tests** - Business logic and API layer testing
- **Snapshot Tests** - UI component visual regression testing
- **Test Plans** - Organized test execution and CI/CD integration

## 📋 Requirements

- **Xcode 16** or later
- **iOS 18.0+** deployment target
- **Swift 5.0+**
- **GitHub Personal Access Token** for API access

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/github-followers-info.git
cd github-followers-info
```

### 2. Configure GitHub Token

1. **Generate a GitHub Personal Access Token**
   - Visit [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
   - Click "Generate new token" → "Generate new token (classic)"
   - Select scopes: `public_repo` and `read:user`
   - Copy the generated token

2. **Configure the app**
   ```bash
   cp Config-Template.swift Config.swift
   ```
   
3. **Edit Config.swift** and replace the placeholder:
   ```swift
   import Foundation

   public struct Config {
       public static let githubToken = "your_actual_github_token_here"
       public static let baseURL = "https://api.github.com"
   }
   ```

### 3. Build and Run

1. Open `GithubFollowersApp.xcworkspace` in Xcode 16
2. Select your target device or simulator
3. Build and run (`Cmd+R`)

## 🧪 Testing

### Running Tests
```bash
# Run all tests
xcodebuild test -workspace GithubFollowersApp.xcworkspace -scheme GithubFollowersApp

# Or use Xcode
# Press Cmd+U to run all tests
```

### Test Coverage
- **Unit Tests**: API mappers, endpoints, and business logic
- **Integration Tests**: HTTP client and networking layer
- **Snapshot Tests**: UI components across different configurations
- **App Tests**: Scene delegate and app composition

### Important Testing Notes
- **Simulator Language**: Set to English for consistent snapshot results
  - `Simulator > Settings > General > Language & Region`
  - Remove non-English languages for CI compatibility
- **Xcode Version**: Snapshot tests optimized for Xcode 16

## 🏗 Architecture

### Project Structure
```
github-followers-info/
├── GithubFollowers/           # Core Framework
│   ├── GithubFollowers/       # Business Logic
│   │   ├── Follower/         # Follower feature
│   │   ├── Repository/       # Repository feature  
│   │   ├── User Info/        # User info feature
│   │   └── Shared/           # Common utilities
│   ├── GithubFollowersiOS/   # UI Framework
│   └── GithubFollowersTests/ # Unit Tests
├── GithubFollowersApp/        # Main App
│   ├── GithubFollowersApp/   # App composition
│   └── GithubFollowersAppTests/
└── screenshots/              # Documentation assets
```

### Architectural Principles
- **Separation of Concerns**: Clear boundaries between layers
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification

### Data Flow
1. **UI Layer** triggers user actions
2. **Presenter** handles UI logic and coordinates
3. **Use Cases** execute business logic
4. **Repository** abstracts data access
5. **API Layer** handles GitHub API communication

## 🔐 Security

- **Token Protection**: `Config.swift` excluded from version control
- **Network Security**: HTTPS-only communication
- **Data Validation**: Input sanitization and error handling
- **No Sensitive Data**: No hardcoded credentials or secrets

## 🌍 Localization & Accessibility

### Supported Features
- **Dynamic Type**: All text scales with system settings
- **Voice Over**: Screen reader compatibility
- **Dark Mode**: System appearance support
- **Localization**: String externalization ready
- **Right-to-Left**: Layout adaptation support

### Languages
- English (primary)
- Japanese (partial - included in project structure)

## 📝 API Integration

### GitHub REST API
- **Endpoints Used**:
  - `/users/{username}` - User information
  - `/users/{username}/followers` - User followers
  - `/users/{username}/repos` - User repositories

⭐ **Star this repository if you found it helpful!**
