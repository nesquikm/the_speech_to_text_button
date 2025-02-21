/// The result of the speech to text
class TheSpeechToTextResult {
  /// Create a new result
  const TheSpeechToTextResult({
    required this.text,
    required this.confidence,
    required this.isFinal,
  });

  /// The text of the result
  final String text;

  /// The confidence of the result
  final double confidence;

  /// Whether the result is final
  final bool isFinal;
}
