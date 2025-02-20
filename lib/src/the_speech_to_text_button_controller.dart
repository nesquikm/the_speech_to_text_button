import 'package:flutter/foundation.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state.dart';

class TheSpeechToTextButtonController
    extends ValueNotifier<TheSpeechToTextState> {
  TheSpeechToTextButtonController()
    : super(
        const TheSpeechToTextState(type: TheSpeechToTextStateType.notReady),
      );

  final onCheckPermissions = ValueNotifier<bool>(false);
  final onStart = ChangeNotifier();
  final onStop = ChangeNotifier();

  void checkPermissions({bool askIfNeeded = false}) {
    onCheckPermissions.value = askIfNeeded;
  }

  void start() {
    onStart.notifyListeners();
  }

  void stop() {
    onStop.notifyListeners();
  }

  @override
  void dispose() {
    onCheckPermissions.dispose();
    onStart.dispose();
    onStop.dispose();
    super.dispose();
  }
}
