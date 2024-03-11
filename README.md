
# Title: Flutter GitHub User Explorer with Bloc

## Description:

A Flutter application that leverages the Bloc state management library and the GitHub API to retrieve, display, and navigate through a list of GitHub users. Explore profiles and gain insights into the developer community.

## Features:

Fetches User List: Seamlessly retrieves a list of GitHub users using the GitHub API.
User Profile Details: Provides a dedicated screen to showcase each user's profile information, including username, avatar, public repositories, followers, and following.
Intuitive Navigation: Offers a smooth user experience for navigating between the user list and individual profile screens.
Bloc State Management: Utilizes Bloc for a predictable and organized approach to managing application state.
Cross-Platform Compatibility: Built with Flutter for seamless deployment on iOS and Android devices.
Delightful User Interface: Delivers an engaging and visually appealing user experience.
Getting Started:

Clone the Repository: Use git clone https://github.com/tosyak/github_users_list/tree/main to clone this repository.

## Set Up Dependencies: Run flutter pub get to install the required dependencies:

dio: ^5.4.1 (HTTP client for API calls)
flutter_bloc: ^8.1.4 (Bloc state management)
flutter_localizations (for localization support)
go_router: ^13.2.0 (routing and navigation)
internet_connection_checker: ^1.0.0+1 (checks internet connectivity)
intl (internationalization support)
logger: ^2.1.0 (logging for debugging)
lottie: ^3.1.0 (optional: for animations)
shared_preferences: ^2.2.2 (for storing persistent data)

## Configure GitHub API Token:

Create a Personal Access Token: Visit your GitHub settings (https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) and generate a new personal access token with appropriate scopes (e.g., repo).
Store Token Securely: Place the token in a secure location within your project, typically in the 

## lib/data/network/api_service.dart file. 

Important: Do not commit this file to version control (e.g., Git) to prevent exposing the token publicly.
Run the App: Execute flutter run to launch the application on your connected device or emulator.

# Additional Notes:

Feel free to customize the app further by adding features like search functionality or filtering options for the user list.
Consider incorporating error handling and user feedback mechanisms to enhance the app's robustness.
Ensure you adhere to GitHub's API rate limits and terms of service when making API calls.
This README provides a clear overview of the app's purpose, features, setup instructions, and highlights the use of Bloc and essential dependencies. It also emphasizes best practices for GitHub API token security.
