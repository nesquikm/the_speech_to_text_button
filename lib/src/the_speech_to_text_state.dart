import 'package:the_speech_to_text_button/src/the_speech_to_text_error.dart';

/// The state of the speech to text button
class TheSpeechToTextState {
  /// Create a new state
  const TheSpeechToTextState({required this.type, this.error});

  /// The type of the speech to text state
  final TheSpeechToTextStateType type;

  /// The error of the speech to text state
  final TheSpeechToTextError? error;
}

/// The type of the speech to text state
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
