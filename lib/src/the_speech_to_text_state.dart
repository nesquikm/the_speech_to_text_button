import 'package:the_speech_to_text_button/src/the_speech_to_text_error.dart';

class TheSpeechToTextState {
  const TheSpeechToTextState({required this.type, this.error});

  final TheSpeechToTextStateType type;
  final TheSpeechToTextError? error;
}

enum TheSpeechToTextStateType {
  /// Not ready to listen
  notReady,

  /// Listening for speech
  listening,

  /// Not listening for speech, but not all results have been delivered
  finishing,

  /// Idle, ready to listen, all results have been delivered
  idle,
}
