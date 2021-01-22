# The Reddit Client is a placeholder for the infrastructure

I was curious how to setup up a project which the ability to scale.  It is basically a dummy for everything around the project.

*  Podfile for SwiftLint and R.swift (more coming soon)
*  Fastlane
*  Github Actions for CI / CD including the following steps: 
    * On pull request to main branch
    * Run SwiftLintLane 
    * Run BuildLane and upload necessary results as artifacts
    * Test jobs will start in parallel
