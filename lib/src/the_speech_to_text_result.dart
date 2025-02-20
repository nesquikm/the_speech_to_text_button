class TheSpeechToTextResult {
  TheSpeechToTextResult({
    required this.text,
    required this.confidence,
    required this.isFinal,
  });

  final String text;
  final double confidence;
  final bool isFinal;
}
