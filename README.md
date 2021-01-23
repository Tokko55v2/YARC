# About

It's a CRUD app that pulls the highest-rated posts from the Reddit page to the application. 

The app itself and its ability to pull posts from Reddit is nothing special it's more a dummy for the infrastructure around it. 

More about the infrastructure is coming soon as especially with more details. However, the core function of the infrastructure is described below.


# The Reddit Client is a placeholder for the infrastructure

I was curious how to setup up a project which the ability to scale.  It is basically a dummy for everything around the project.

*  Podfile for SwiftLint and R.swift (more coming soon)
*  Fastlane
*  Github Actions for CI / CD including the following steps: 
    * On pull request to main branch
    * Run SwiftLintLane 
    * Run build
