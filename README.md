# Pass Vault

A new Flutter Password Vault and Generator project using Sqflite and Provider.

**Features:**

- Dark and Light Theme mode
- Save User Data to local Storage
- Search Passwords
- CRUD Passwords
- Generate Random Password
- Password Strength Meter
- Get Website Favicon

**Packages we are using:**

- form_field_validator: [link](https://pub.dev/packages/form_field_validator)
- persistent_bottom_nav_bar: [link](https://pub.dev/packages/persistent_bottom_nav_bar)
- provider: [link](https://pub.dev/packages/provider)
- sqflite: [link](https://pub.dev/packages/sqflite)
- shared_preferences: [link](https://pub.dev/packages/shared_preferences)
- cached_network_image: [link](https://pub.dev/packages/cached_network_image)
- favicon: [link](https://pub.dev/packages/favicon)
- intl: [link](https://pub.dev/packages/intl)
- path: [link](https://pub.dev/packages/path)
- flutter_svg: [link](https://pub.dev/packages/flutter_svg)
- webview: [link](https://pub.dev/packages/webview_flutter)

<!-- This is a complete functional application that works on both Android and iOS devices. -->

# Pass Vault App UI Preview

The app features a modern, clean interface with both light and dark themes. Below are the screenshots organized by functionality, showing both theme variations side by side for easy comparison.

## Table of Contents

- [Onboarding & Authentication](#onboarding--authentication)
  - [Splash & Introduction](#splash--introduction)
  - [Authentication](#authentication)
- [Main Features](#main-features)
- [Password Management](#password-management)
- [Settings & Customization](#settings--customization)
- [App States](#app-states)
  - [Theme Selection](#theme-selection)
  - [Empty States](#empty-states)

## App Screenshots

### Onboarding & Authentication

The initial screens users encounter when launching and setting up the app.

#### Splash & Introduction

First impressions and onboarding experience:

<p float="left">
  <img src="preview/light_splash.png" width="200" alt="Light Splash Screen"/>
  <img src="preview/dark_splash.png" width="200" alt="Dark Splash Screen"/>
  <img src="preview/light_intro1.png" width="200" alt="Light Intro Screen 1"/>
  <img src="preview/dark_intro1.png" width="200" alt="Dark Intro Screen 1"/>
</p>

<p float="left">
  <img src="preview/light_intro2.png" width="200" alt="Light Intro Screen 2"/>
  <img src="preview/dark_intro2.png" width="200" alt="Dark Intro Screen 2"/>
  <img src="preview/light_login.png" width="200" alt="Light Login Screen"/>
  <img src="preview/dark_login.png" width="200" alt="Dark Login Screen"/>
</p>

#### Authentication

Secure access and account management:

<p float="left">
  <img src="preview/light_register.png" width="200" alt="Light Register Screen"/>
  <img src="preview/dark_register.png" width="200" alt="Dark Register Screen"/>
  <img src="preview/light_change_pass.png" width="200" alt="Light Change Password Screen"/>
  <img src="preview/dark_change_pass.png" width="200" alt="Dark Change Password Screen"/>
</p>

### Main Features

Core functionality and primary user interface:

<p float="left">
  <img src="preview/light_homepage.png" width="200" alt="Light Home Screen"/>
  <img src="preview/dark_homepage.png" width="200" alt="Dark Home Screen"/>
  <img src="preview/light_datascreen.png" width="200" alt="Light Data Screen"/>
  <img src="preview/dark_datascreen.png" width="200" alt="Dark Data Screen"/>
</p>

### Password Management

Tools for managing and generating secure passwords:

<p float="left">
  <img src="preview/light_generator.png" width="200" alt="Light Generator Screen"/>
  <img src="preview/dark_generator.png" width="200" alt="Dark Generator Screen"/>
  <img src="preview/light_input.png" width="200" alt="Light Input Screen"/>
  <img src="preview/dark_input.png" width="200" alt="Dark Input Screen"/>
</p>

### Settings & Customization

App configuration and personalization options:

<p float="left">
  <img src="preview/light_settings.png" width="200" alt="Light Settings Screen"/>
  <img src="preview/dark_settings.png" width="200" alt="Dark Settings Screen"/>
  <img src="preview/light_search.png" width="200" alt="Light Search Screen"/>
  <img src="preview/dark_search.png" width="200" alt="Dark Search Screen"/>
</p>

### App States

Different states and visual modes of the application.

#### Theme Selection

Theme customization options:

<p float="left">
  <img src="preview/light_theme_pick.png" width="200" alt="Light Theme Picker"/>
  <img src="preview/dark_theme_pick.png" width="200" alt="Dark Theme Picker"/>
</p>

#### Empty States

Placeholder screens when no data is available:

<p float="left">
  <img src="preview/light_no_data.png" width="200" alt="Light No Data Screen"/>
  <img src="preview/dark_no_data.png" width="200" alt="Dark No Data Screen"/>
</p>

# Change App Icon

## Package - flutter_launcher_icons: [link](https://pub.dev/packages/flutter_launcher_icons)

- step 1 : Replace the logo.png image with your logo.
- step 2 : Change the logo path in pubspec.yaml file
- step 3 : Run "flutter pub get"
- step 4 : Run "flutter pub run flutter_launcher_icons:main"

# Change Splash Screen

## Package - flutter_native_splash: [link](https://pub.dev/packages/flutter_native_splash)

- step 1 : Replace the logo.png image with your logo.
- step 2 : Change the logo path in pubspec.yaml file
- step 3 : Run "flutter pub clean"
- step 4 : Run "flutter pub get"
- step 5 : Run "flutter pub run flutter_native_splash:create"

# Update Pods

## Run All Commands

<br>
cd ios

pod cache clean --all

rm Podfile.lock

rm -rf .symlinks/

cd ..

flutter clean

flutter pub get

cd ios

pod update

pod repo update

pod install --repo-update

pod update

pod install

cd ..

## You must be in your application directory to run those commands
