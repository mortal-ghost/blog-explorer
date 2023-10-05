# blog_explorer

## How to build

To build the project, you should Flutter SDK installed on your machine. 
You can find the installation guide [here](https://flutter.dev/docs/get-started/install).

You also need to have a device or emulator connected to your machine.
To check if you have a device connected, run the following command:

```bash
flutter devices
```

If you have a device connected, you should see it on the list.
If you don't have a device connected, you can start an emulator with the following command:

```bash
flutter emulators --launch <emulator_id>
```

To get the list of available emulators, run the following command:

```bash
flutter emulators
```

To create a new emulator, run the following command:

```bash
flutter emulators --create [--name xyz]
```

After you have a device connected, you can run the project.

To run the project, run the following commands:
```bash
flutter pub get
```

```bash
flutter run
```
The project should start on your connected device.

To build the project, run the following command:

```bash
flutter build
```

This command will build the project for all platforms. 
To build the project for a specific platform, run the following command:

```bash
flutter build <platform>
```

For example, to build the project for Android, run the following command:

```bash
flutter build apk
```

To build the project for iOS, run the following command:

```bash
flutter build ios
```
If you want to build the project for iOS, you need to have a Mac with Xcode installed.

The build files will be located in the `build` folder.
The build files for Android will be located in the `build/app/outputs/apk/release` folder.

If you have Android Studio installed, you can build the project from the IDE.
To do that, open the project in Android Studio and click on the `Run` button. 
The project will be built and run on your connected device.

## Features
- The app have a list of blog posts with a favourite button.
- At the top, there is a favourite button that shows only favourite posts.
- Each post can be opened in a new screen.
- Provider is used for state management.
- SQLite is used for storing favourite posts locally and for offline mode.

