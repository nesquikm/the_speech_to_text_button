/// The error of the speech to text button
class TheSpeechToTextError {
  /// Create a new error
  const TheSpeechToTextError({required this.type, this.text});

  /// The type of the error
  final TheSpeechToTextErrorType type;

  /// The text of the error
  final String? text;
}

/// The type of the error
enum TheSpeechToTextErrorType {
  /// Permission denied
  permissionDenied,

  /// Permission permanently denied
  permissionPermanentlyDenied,

  /// Internal error
  internalError,

  /// Language not supported
  languageNotSupported,

  /// Not recognized
  notRecognized,

  /// Unknown error
  unknown,
}
