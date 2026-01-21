# XcodeProjectCLI command reference (validated)

## Setup

- Install once with `brew install xcp`.
- All examples below were executed with `xcp 1.2.1` on a fresh Xcode project.

## Global notes from real usage

- Absolute paths work reliably for both project and file/group arguments.
- `--project-only` updates the project file and skips filesystem changes.
- For shell hex colors, quote `#RRGGBB` values because `#` starts a comment.
- `list-targets --file` and `set-target` require the file to be a PBXFileReference. Files managed by File System Synchronized groups are not found unless added via `xcp add-file`.

## Common recipes

Add a new file and assign targets:

```bash
xcp add-file /path/App.xcodeproj --file /path/Sources/NewFile.swift --targets App --create-groups
```

Move a file while preserving target membership:

```bash
xcp move-file /path/App.xcodeproj --file /path/Old.swift --dest /path/New.swift
```

Rename a group:

```bash
xcp rename-group /path/App.xcodeproj --group /path/OldGroup --name NewGroup
```

Set a build setting across all targets/configs:

```bash
xcp set-build-setting /path/App.xcodeproj --key SWIFT_VERSION --value 5.9
```

Add an image asset:

```bash
xcp add-image-asset /path/Assets.xcassets --file /path/image.png --asset-path Icons/App --mode template
```

## Targets

List all targets:

```bash
xcp list-targets /Users/khoi/Downloads/test/test.xcodeproj
```

Example output:

```
test
testTests
testUITests
```

List targets for a file reference:

```bash
xcp list-targets /Users/khoi/Downloads/test/test.xcodeproj --file /Users/khoi/Downloads/test/test/XCPGroup/XCPFile.swift
```

Set target membership for a file:

```bash
xcp set-target /Users/khoi/Downloads/test/test.xcodeproj --file /Users/khoi/Downloads/test/test/XCPGroup/XCPFile.swift --targets test
```

## Groups

Add group and create missing folders:

```bash
xcp add-group /Users/khoi/Downloads/test/test.xcodeproj --group /Users/khoi/Downloads/test/test/XCPGroup --create-groups
```

Project-only group entry (no disk changes):

```bash
xcp add-group /Users/khoi/Downloads/test/test.xcodeproj --group /Users/khoi/Downloads/test/test/XCPProjectOnlyGroup --project-only
```

Rename group:

```bash
xcp rename-group /Users/khoi/Downloads/test/test.xcodeproj --group /Users/khoi/Downloads/test/test/XCPGroup --name XCPGroupRenamed
```

Move group into destination:

```bash
xcp move-group /Users/khoi/Downloads/test/test.xcodeproj --group /Users/khoi/Downloads/test/test/XCPGroupRenamed --dest /Users/khoi/Downloads/test/test/XCPDest
```

Delete group:

```bash
xcp delete-group /Users/khoi/Downloads/test/test.xcodeproj --group /Users/khoi/Downloads/test/test/XCPDest/XCPGroupRenamed
```

## Files

Add file to target and print targets:

```bash
xcp add-file /Users/khoi/Downloads/test/test.xcodeproj --file /Users/khoi/Downloads/test/test/XCPGroup/XCPFile.swift --targets test --create-groups --print-targets
```

Example output:

```
test
```

Move file and print targets:

```bash
xcp move-file /Users/khoi/Downloads/test/test.xcodeproj --file /Users/khoi/Downloads/test/test/XCPDest/XCPGroupRenamed/XCPFile.swift --dest /Users/khoi/Downloads/test/test/XCPDest2/XCPFile.swift --print-targets
```

Rename file:

```bash
xcp rename-file /Users/khoi/Downloads/test/test.xcodeproj --file /Users/khoi/Downloads/test/test/XCPDest2/XCPFile.swift --name XCPFileRenamed.swift
```

Delete file:

```bash
xcp delete-file /Users/khoi/Downloads/test/test.xcodeproj --file /Users/khoi/Downloads/test/test/XCPDest2/XCPFileRenamed.swift
```

## Build settings

Read build setting:

```bash
xcp get-build-setting /Users/khoi/Downloads/test/test.xcodeproj --target test --key PRODUCT_NAME
```

Example output:

```
$(TARGET_NAME)
```

Write build setting:

```bash
xcp set-build-setting /Users/khoi/Downloads/test/test.xcodeproj --targets test --configs Debug --key XCP_TEST_SETTING --value 1
```

Verify the value:

```bash
xcp get-build-setting /Users/khoi/Downloads/test/test.xcodeproj --target test --config Debug --key XCP_TEST_SETTING
```

Example output:

```
1
```

## Asset catalogs (.xcassets)

Add image asset:

```bash
xcp add-image-asset /Users/khoi/Downloads/test/test/Assets.xcassets --file /Users/khoi/Downloads/test/test/xcp-test.png --asset-path XCP/TestImage --mode template
```

Add data asset:

```bash
xcp add-data-asset /Users/khoi/Downloads/test/test/Assets.xcassets --file /Users/khoi/Downloads/test/test/xcp-data.txt --asset-path XCP/TestData
```

Add color asset (quoted hex):

```bash
xcp add-color-asset /Users/khoi/Downloads/test/test/Assets.xcassets --color '#FF00FF' --asset-path XCP/TestColor --dark-color '#00FF00'
```

List assets:

```bash
xcp list-assets /Users/khoi/Downloads/test/test/Assets.xcassets
```

Example output:

```
> Images
XCP/TestImage

> Data Files
XCP/TestData

> Colors
AccentColor
XCP/TestColor
```

Move asset:

```bash
xcp move-asset /Users/khoi/Downloads/test/test/Assets.xcassets --asset-path XCP/TestImage --dest XCP/TestImageMoved
```

Delete assets:

```bash
xcp delete-asset /Users/khoi/Downloads/test/test/Assets.xcassets --asset-path XCP/TestImageMoved
xcp delete-asset /Users/khoi/Downloads/test/test/Assets.xcassets --asset-path XCP/TestData
xcp delete-asset /Users/khoi/Downloads/test/test/Assets.xcassets --asset-path XCP/TestColor
```
