## iOS

Info.plist:

	<key>NSMicrophoneUsageDescription</key>
	<string>Allow $(PRODUCT_NAME) to access your microphone to record audio to transcribe text</string>
	<key>NSSpeechRecognitionUsageDescription</key>
	<string>Allow $(PRODUCT_NAME) to access your microphone to record and transcribe audio to text</string>


Podfile:
platform :ios, '14.0'

    target.build_configurations.each do |config|
      # for more information: https://github.com/BaseflowIT/flutter-permission-handler/blob/master/permission_handler/ios/Classes/PermissionHandlerEnums.h
      # e.g. when you don't need camera permission, just add 'PERMISSION_CAMERA=0'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.microphone
        'PERMISSION_MICROPHONE=1',

        ## dart: PermissionGroup.speech
        'PERMISSION_SPEECH_RECOGNIZER=1',
      ]
    end


Adnroid:
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

