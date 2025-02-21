import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_error.dart';

/// Extension for [SpeechRecognitionError]
extension SpeechRecognitionErrorExt on SpeechRecognitionError {
  /// Convert the error to a [TheSpeechToTextErrorType]
  TheSpeechToTextErrorType get toSpeechToTextErrorType {
    return switch (errorMsg) {
      /// Android errors
      'error_audio_error' => TheSpeechToTextErrorType.internalError,
      'error_client' => TheSpeechToTextErrorType.internalError,
      'error_permission' => TheSpeechToTextErrorType.permissionDenied,
      'error_network' => TheSpeechToTextErrorType.internalError,
      'error_network_timeout' => TheSpeechToTextErrorType.internalError,
      'error_busy' => TheSpeechToTextErrorType.internalError,
      'error_server' => TheSpeechToTextErrorType.internalError,
      'error_speech_timeout' => TheSpeechToTextErrorType.internalError,
      'error_language_not_supported' =>
        TheSpeechToTextErrorType.languageNotSupported,
      'error_language_unavailable' =>
        TheSpeechToTextErrorType.languageNotSupported,
      'error_server_disconnected' => TheSpeechToTextErrorType.internalError,
      'error_too_many_requests' => TheSpeechToTextErrorType.internalError,

      // iOS errors
      'error_speech_recognizer_disabled' =>
        TheSpeechToTextErrorType.permissionDenied,
      'error_retry' => TheSpeechToTextErrorType.internalError,

      // iOS and Android errors
      'error_no_match' => TheSpeechToTextErrorType.notRecognized,
      _ => TheSpeechToTextErrorType.unknown,
    };
  }
}
