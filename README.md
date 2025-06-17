# GitHub Followers Info

A Swift iOS application for viewing GitHub user followers and repository information.

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