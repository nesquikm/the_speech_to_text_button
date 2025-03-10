import 'package:the_speech_to_text_button/src/the_speech_to_text_error.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state.dart';

/// Extension for [TheSpeechToTextState]
extension TheSpeechToTextStateExt on TheSpeechToTextState {
  /// Update the state with an error
  TheSpeechToTextState withError(TheSpeechToTextError error) {
    final t = switch (error.type) {
      TheSpeechToTextErrorType.permissionDenied =>
        TheSpeechToTextStateType.notReady,
      TheSpeechToTextErrorType.permissionPermanentlyDenied =>
        TheSpeechToTextStateType.notReady,
      TheSpeechToTextErrorType.internalError => type,
      TheSpeechToTextErrorType.languageNotSupported => type,
      TheSpeechToTextErrorType.notRecognized => type,
      TheSpeechToTextErrorType.unknown => type,
    };

    return TheSpeechToTextState(type: t, error: error);
  }

  /// Update the state with a permission error
  TheSpeechToTextState withPermissionError({
    required bool isPermanentlyDenied,
  }) {
    final e = TheSpeechToTextError(
      type:
          isPermanentlyDenied
              ? TheSpeechToTextErrorType.permissionPermanentlyDenied
              : TheSpeechToTextErrorType.permissionDenied,
      text:
          '''Please enable microphone and speech recognition permissions in settings''',
    );
    return withError(e);
  }

  /// Clear the permission error
  TheSpeechToTextState clearPermissionError() {
    final (t, e) = (switch (error?.type) {
      TheSpeechToTextErrorType.permissionDenied => (type, null),
      TheSpeechToTextErrorType.permissionPermanentlyDenied => (type, null),

      null => (type, error),
      TheSpeechToTextErrorType.internalError => (type, error),
      TheSpeechToTextErrorType.languageNotSupported => (type, error),
      TheSpeechToTextErrorType.notRecognized => (type, error),
      TheSpeechToTextErrorType.unknown => (type, error),
    });
    return TheSpeechToTextState(type: t, error: e);
  }

  /// Update the state with a status
  TheSpeechToTextState withStatus(TheSpeechToTextStateType status) {
    return TheSpeechToTextState(type: status);
  }

  /// Set the state to initialized
  TheSpeechToTextState setInitialized() {
    final t = switch (type) {
      TheSpeechToTextStateType.notReady => TheSpeechToTextStateType.idle,

      TheSpeechToTextStateType.listening => type,
      TheSpeechToTextStateType.finishing => type,
      TheSpeechToTextStateType.idle => type,
    };

    return TheSpeechToTextState(type: t);
  }
}
