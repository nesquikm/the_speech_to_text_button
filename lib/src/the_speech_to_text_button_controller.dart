import 'package:flutter/foundation.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state.dart';

/// The controller for the speech to text button
class TheSpeechToTextButtonController
    extends ValueNotifier<TheSpeechToTextState> {
  /// Create a new controller
  TheSpeechToTextButtonController()
    : super(
        const TheSpeechToTextState(type: TheSpeechToTextStateType.notReady),
      );

  /// On check permissions
  final onCheckPermissions = ValueNotifier<bool>(false);

  /// On start
  final onStart = ChangeNotifier();

  /// On stop
  final onStop = ChangeNotifier();

  /// Check permissions
  void checkPermissions({bool askIfNeeded = false}) {
    onCheckPermissions.value = askIfNeeded;
  }

  /// Start listening
  void start() {
    onStart.notifyListeners();
  }

  /// Stop listening
  void stop() {
    onStop.notifyListeners();
  }

  /// Dispose
  @override
  void dispose() {
    onCheckPermissions.dispose();
    onStart.dispose();
    onStop.dispose();
    super.dispose();
  }
}
