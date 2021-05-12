import Foundation
/**
 Runs `xcodegen` for the project

 - parameters:
   - spec: The path to the project spec file
   - project: The path to the folder where the project should be generated
   - quiet: Whether to suppress informational and success messages
   - useCache: Used to prevent unnecessarily generating the project
   - cachePath: A custom path to use for your cache file
   - projectRoot: The path to the project root directory

 Will be installed with `brew` if not available
 Runs `xcodegen` for the project.
*/
public func xcodegen(spec: String? = nil,
                     project: String? = nil,
                     quiet: Any? = nil,
                     useCache: Any? = nil,
                     cachePath: String? = nil,
                     projectRoot: String? = nil) {
  let command = RubyCommand(commandID: "", methodName: "xcodegen", className: nil, args: [RubyCommand.Argument(name: "spec", value: spec),
                                                                                          RubyCommand.Argument(name: "project", value: project),
                                                                                          RubyCommand.Argument(name: "quiet", value: quiet),
                                                                                          RubyCommand.Argument(name: "use_cache", value: useCache),
                                                                                          RubyCommand.Argument(name: "cache_path", value: cachePath),
                                                                                          RubyCommand.Argument(name: "project_root", value: projectRoot)])
  _ = runner.executeCommand(command)
}
