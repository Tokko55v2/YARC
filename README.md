<p float="center">
  <img src="Assets/screen1.png" width="250" />
  <img src="Assets/screen2.png" width="250" />
</p>

<p align="center">
  <a href="https://github.com/Tokko55v2/YARC/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/Tokko55v2/YARC"/>
  </a>
</p>

# About

It's a CRUD application that has two main components a YARC_SDK which handles all the "backend" logic and the YARC itself which presents the data in a certain way.

The app itself and its ability to pull posts from Reddit is nothing special it's more a dummy for the infrastructure around it. 

This repo should give me a apportunite to work with many infrastrucure tools like CI, Fastlane, XcodeGen ect.

## Start the Project
Pull the project and direct to the folder `app` via Terminal.
Use the command line `xcodegen generate` to create a `YARC.xcodeproj`.

# The Infrastructure

I was curious how to setup up a project which has the ability to scale.  It is basically a dummy for everything around the project.

* YARC_SDK
* Podfile for SwiftLint and R.swift
* Fastlane
* XcodeGen
* Github Actions

## YARC_SDK
Fetches all the data between the Reddit API and the Application, including Error handling.
[YARC_SDK](https://github.com/Tokko55v2/YARC_SDK)

## Podfile
The Podfile is a specification that describes the dependencies of the targets of one or more Xcode projects. The file should simply be named Podfile [PodFile](https://guides.cocoapods.org/using/the-podfile.html)
### Swiftlint
A tool to enforce Swift style and conventions, loosely based on the now archived GitHub Swift Style Guide [SwiftLint](https://github.com/realm/SwiftLint)
### R.swift
Get strong typed, autocompleted resources like images, fonts and segues in Swift projects [R.swift](https://github.com/mac-cain13/R.swift)

## Fastlane
Fastlane is a tool for iOS and Android developers to automate tedious tasks like generating screenshots, dealing with provisioning profiles, and releasing your application. [Fastlane](https://github.com/fastlane/fastlane)
### SwiftLint for CI
To run SwiftLint at Github Actions it was required to write a job for Github Actions. 
It is also necessary to declear in `FastFile.swift` a function called `swiftLineLane`.
```
jobs:
  RunLinter:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Install dependencies
        run: bundle install

      - name: Run linter
        run: bundle exec fastlane swiftLintLane
```

```
func swiftLintLane() {
    desc("Run SwiftLint")
    swiftlint(configFile: "app/.swiftlint.yml",
              strict: true,
              ignoreExitStatus: false,
              raiseIfSwiftlintError: true,
              executable: "Pods/SwiftLint/swiftlint")
}
```
## XcodeGen
XcodeGen is a command line tool written in Swift that generates your Xcode project using your folder structure and a project spec. [XcodeGen](https://github.com/yonaskolb/XcodeGen)

## Github Actions
For CI / CD including the following steps: 
* On pull request to main branch
* Run SwiftLintLane
