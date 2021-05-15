# Type a script or drag a script file from your workspace to insert its path.
if [ -z "$CI" ]; then
    $SRCROOT/../Pods/SwiftLint/swiftlint --config .swiftlint.yml
fi
