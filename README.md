# Data Collector

## Overview

An application used during Systematic Property Titling to gather owner information for use by the titling agency.
This communicates with our [Systematic Application Database](https://gitlab.com/mediciland/tools/sltdb) to store the information gathered across multiple application instances

## Building from Android Studio

#### Prerequisites
---

* [Android Studio](https://developer.android.com/studio?gclid=Cj0KCQjw2NyFBhDoARIsAMtHtZ6iZDqZH5ST7d4xlnwfdMGD8GoquRh0Q6B_KJRmUl-MRyj-OPSPrLwaAgo7EALw_wcB&gclsrc=aw.ds)
* [Git](https://git-scm.com/downloads)
* [Android NDK](#steps-to-run-the-project)
   * Android SDK from 25 up to the latest.

In the welcome screen choose the "Open an existing Android Studio" option and
select the folder containing this README.

Android Studio will proceed with the build.

<p>&nbsp;</p>

## STEPS TO RUN THE PROJECT.
---
<p>&nbsp;</p>
### Installing required components
1. Go to the **SDK MANAGER**
2. Select **Android SDK**
3. Check the SDK from android 5.0(LOLLIPOP) up to the Latest Version at the moment.
4. Go to **SDK Tools** and check the option **Show Package Details**
5. On the Android SDK Build-Tools, check from: SDK 30 up to the latest at the moment. (is optional if you wish to add more SDK alternatives such as 27.0, 28 or 29).
6. On the NDK(Side by side) check from 20.1 up to the latest at the moment.
7. Make sure that you have the latest **Android SDK Command-line Tools**
8. Finally select the following:
   - Android Emulator
   - Android SDK Platform-Tools
   - Google play APK Expansion Library
   - Google play Instant Development SDK
   - Google Play Licensing Library
   - Google Play Services
   - Intel x86 Emulator Accelerator (HAXM installer)
9. Click on Apply and accept the Terms and Conditions.

<p>&nbsp;</p>


    * Setting up emulated Devices:
      * Cmd + Shift + A —> Type AVD Manager and select
      * Create New Virtual Device
      * Select Device —> Tablet, Nexus 7
      * Click Next
      * Select System Image PIE (API 28)—> Click Download
      * Click Next
      * Enter Name for Device —> Click Finish
      * Note: If unsure of device, Pixel 2XL(Phone) and Pixel C (Tablet) work well

<p>&nbsp;</p>

#### Build, Test, & Run:
  * Setup: Open Android Studio, select `Import project (Gradle, Eclipse ADT, etc.)`, and follow the prompts
  * Build & Run: Click the Run button at the top of android studio
    * To switch between a debug/dev and qa on the bottom-left side of AS select `Build Variants` and change both `app` and `data-repository` to the expected variant
    * A `mediciventures.com`, `mediciland.com`, or `mlgzambia.com` email is required to login
 * Test: run `./gradlew testDebugUnitTest` or run the tests through AS
 * Select the build variant of either debug or qa (These will connect app with dev server rather than having to build your own)
    * Build —> Select Variant
* Build Project
    * Build —> Make Project
* In taskbar (Beside Green Hammer)
    * Select configuration 'app'
    * Select Device you wish to use
    * Click the play button

<p>&nbsp;</p>

#### Unit Testing
Thorough Unit Testing of code that matters is our target, not arbitrary metrics such as "90%".
Tools:
 * MockK (not Mockito)

<p>&nbsp;</p>

#### App Authentication
Register your local generated certificate key with the server (Once only):

`keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android`

<p>&nbsp;</p>

### Known issues when building the project:

**Gradle could not start your build:**

```
> Could not create service of type FileAccessTimeJournal using GradleUserHomeScopeServices.createFileAccessTimeJournal().
   > Timeout waiting to lock journal cache (/Users/<username>/.gradle/caches/journal-1). It is currently in use by another Gradle instance.
```

Just simply restart your computer.

**Android Studio needs more memory**
Sometimes Android Studio needs more memory to run the project.
To fix this, open gradle.properties and add the following line:

```
org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
```

save and rebuild the project.

## ktlint
---
This project is formatted and linted with ktlint using the [ktlint-gradle plugin](https://github.com/JLLeitschuh/ktlint-gradle).

You can install the [ktlint Intellij plugin](https://plugins.jetbrains.com/plugin/15057-ktlint-unofficial-)
for some support for linting within Android Studio.


### Add Commit Hook
---
./gradlew addKtlintCheckGitPreCommitHook

This adds a pre commit hook that lints all staged files upon commit.


### Manually Auto-format
---
./gradlew ktlintFormat

This auto-formats all Kotlin files in the project.


### Manually Check
---
./gradlew ktlintCheck

This manually runs the linter against all Kotlin files in the project.
