# TheSpeechToTextButton

[![Analyze and test all][analyze_and_test_badge]][analyze_and_test_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

A flutter widget that transcribes speech to text.

## Features

- Android and iOS support
- Web support
- MacOS support
- Customizable builder
- Permission handling
- Error handling

## Why does this package exist?

Handling speech recognition is a pain. You should handle permissions, and you shouldn't ask permissions when app just started. It's better to ask permissions when user starts to use feature. Also you should handle errors and provide a good user experience.

This package handles all of this.

## Getting started

To use this package, add `the_speech_to_text_button` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

### iOS & MacOS

You need to add the following to your `Info.plist` file:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Allow $(PRODUCT_NAME) to access your microphone to record audio to transcribe text</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Allow $(PRODUCT_NAME) to access your microphone to record and transcribe audio to text</string>
```

Please rephrase the usage description to your needs.

Add the following to your `Podfile`:

```ruby
platform :ios, '14.0'
...

  target.build_configurations.each do |config|
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
      '$(inherited)',

      ## dart: PermissionGroup.microphone
      'PERMISSION_MICROPHONE=1',

      ## dart: PermissionGroup.speech
      'PERMISSION_SPEECH_RECOGNIZER=1',
    ]
  end
```

### Android

Add the following to your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.BLUETOOTH"/>
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
<queries>
        <intent>
            <action android:name="android.speech.RecognitionService" />
        </intent>
</queries>
```

Permission handling is done by [permission_handler][permission_handler_link]. Please refer to the [permission_handler documentation][permission_handler_docs] for more information.

Speech recognition is done by [speech_to_text][speech_to_text_link]. Please refer to the [speech_to_text documentation][speech_to_text_docs] for more information.

## Usage

```dart
  TheSpeechToTextButton(
    onResult: (result) {
      // Handle the result. For example, update a text field.
    },
    askPermissionDialogBuilder: askPermissionDialogBuilder,
    ),
```

### Ask permission dialog builder

The `askPermissionDialogBuilder` is a function that builds a dialog to ask the user to grant permission to access the microphone and speech recognition.

```dart
  void askPermissionDialogBuilder(void Function()? onOpenSettings) {
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Permission required'),
            content: const Text(
              'Please enable microphone and speech recognition',
            ),
            actions: [
              if (onOpenSettings != null)
                TextButton(
                  onPressed: onOpenSettings,
                  child: const Text('Open settings'),
                ),
            ],
          ),
    );
  }
```

Take a note that onOpenSettings is optional. If it is not provided, the dialog will not have a button to open the settings.

Also you can provide a controller to the button. It allows you to control the state of the button outside of the widget. Also it allows you to handle state changes and ask for permissions.

[analyze_and_test_badge]: https://github.com/nesquikm/the_speech_to_text_button/actions/workflows/analyze-and-test.yaml/badge.svg
[analyze_and_test_link]: https://github.com/nesquikm/the_speech_to_text_button/actions/workflows/analyze-and-test.yaml
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[permission_handler_link]: https://pub.dev/packages/permission_handler
[permission_handler_docs]: https://pub.dev/documentation/permission_handler/latest
[speech_to_text_link]: https://pub.dev/packages/speech_to_text
[speech_to_text_docs]: https://pub.dev/documentation/speech_to_text/latest
