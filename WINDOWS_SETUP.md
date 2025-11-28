# Setting Up UDrive iOS Project on Windows

Since you're working on Windows and Xcode is macOS-only, here are your options to create and build the iOS project:

## Option 1: Use CodeMagic (Recommended - Easiest)

CodeMagic will automatically generate the Xcode project from the `project.yml` file when you run a build.

**Steps:**
1. Make sure all your Swift files are committed to GitHub
2. The `project.yml` file is already in the repo (generates Xcode project automatically)
3. Push to GitHub and trigger a CodeMagic build
4. CodeMagic will:
   - Generate the Xcode project using xcodegen
   - Build the app
   - Create the IPA file

**No Mac needed!**

## Option 2: Use a Cloud Mac Service

If you need to create/modify the Xcode project manually:

1. **MacStadium** - Rent a Mac in the cloud
2. **AWS EC2 Mac instances** - Pay-per-use Mac instances
3. **MacinCloud** - Cloud Mac rental service
4. **GitHub Codespaces** (if available with Mac support)

Then:
- SSH into the Mac
- Clone your repo
- Open in Xcode
- Make changes
- Commit and push

## Option 3: Use XcodeGen Locally (If you get Mac access)

If you have temporary access to a Mac:

```bash
# Install xcodegen
brew install xcodegen

# Generate the project
xcodegen generate

# Open in Xcode
open UDrive.xcodeproj
```

## Option 4: Manual Project Creation (Complex)

You can manually create the `.xcodeproj` file structure, but it's very complex and error-prone. Not recommended.

## Current Setup

Your project is configured to:
- ✅ Auto-generate Xcode project in CodeMagic using `project.yml`
- ✅ Build automatically in CodeMagic
- ✅ Export IPA files

**Just push your code and run a CodeMagic build!**

## Troubleshooting

If CodeMagic build fails with "project not found":
1. Check that `project.yml` is in the repo root
2. Verify xcodegen is being installed in the build script
3. Check build logs for xcodegen errors

If you need to modify the project structure:
1. Edit `project.yml` (much easier than editing Xcode project files)
2. Commit and push
3. CodeMagic will regenerate the project

## Project Structure

The `project.yml` file defines:
- App name: UDrive
- Bundle ID: com.udrive.app
- iOS Deployment Target: 15.0
- All source files in the repo
- Required permissions (Location, Camera, Photo Library)

