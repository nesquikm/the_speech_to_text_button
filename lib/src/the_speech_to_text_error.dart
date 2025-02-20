class TheSpeechToTextError {
  const TheSpeechToTextError({required this.type, this.text});

  final TheSpeechToTextErrorType type;
  final String? text;
}

enum TheSpeechToTextErrorType {
  permissionDenied,
  permissionPermanentlyDenied,
  internalError,
  languageNotSupported,
  notRecognized,
  unknown,
}
