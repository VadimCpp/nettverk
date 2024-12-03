# nettverk

## Idea

Nettverk is a mobile application designed to assist immigrants in Norway with integrating into society through engaging gamification elements. By unifying your existing platforms—borinorge.no, the AI-powered Telegram bot, and the Telegram chats in Oslo and Bergen—the app creates a cohesive community experience that encourages learning, socializing, and active participation in Norwegian life.

## Nettverk MVP Version 1 Proposal

To help you deploy your app as quickly as possible, we'll focus on essential features that can be implemented using your already developed screens: **About Us**, **Home**, **Chats**, and **Settings**. This minimalistic MVP will serve as a foundation for future enhancements while providing immediate value to your community.

### 1. Home Screen

- **Welcome Message**: A friendly greeting introducing users to Nettverk.
- **Latest News Feed**: Display recent articles or updates from **borinorge.no** using an RSS feed or a simple API integration.
- **Quick Links**: Buttons directing users to important resources or sections within the app.

### 2. Chats Screen

- **Telegram Chat Integration**:
  - **Oslo Chat**: A button that opens the Oslo Telegram chat when clicked.
  - **Bergen Chat**: A button that opens the Bergen Telegram chat when clicked.
- **Community Guidelines**: Briefly outline chat rules to ensure respectful communication.

### 3. About Us Screen

- **Mission Statement**: Explain the purpose of Nettverk and its role in helping immigrants integrate into Norwegian society.
- **Team Introduction**: Brief bios of key team members or contributors.
- **Contact Information**: Email address and links to social media profiles for user inquiries.

### 4. Settings Screen

- **Language Options**: Allow users to select their preferred language (e.g., English, Norwegian).
- **Profile Settings**:
  - **Edit Profile**: Basic fields like name and profile picture.
  - **Privacy Settings**: Options to manage data sharing preferences.
- **App Notifications**: Toggle to enable or disable notifications for future updates.

### 5. AI Assistant Access (Optional)

- **Link to Telegram Bot**: Provide a direct link to your AI-powered Telegram bot for users seeking assistance.

### 6. Feedback Mechanism

- **Feedback Form**: A simple form where users can submit feedback or report issues, helping you gather insights for future improvements.

## Development

### Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/to/state-management-sample).

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/to/resolution-aware-images).

### Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter apps](https://flutter.dev/to/internationalization).
