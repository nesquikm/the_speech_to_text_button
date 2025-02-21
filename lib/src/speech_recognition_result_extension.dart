import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_result.dart';

/// Extension for [SpeechRecognitionResult]
extension SpeechRecognitionResultExt on SpeechRecognitionResult {
  /// Convert the result to a [TheSpeechToTextResult]
  TheSpeechToTextResult get toSpeechToTextResult {
    return TheSpeechToTextResult(
      text: recognizedWords,
      confidence: confidence,
      isFinal: finalResult,
    );
  }
}
