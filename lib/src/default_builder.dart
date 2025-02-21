import 'package:flutter/material.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state.dart';

/// The default builder for the speech to text button
Widget defaultBuilder(
  BuildContext context, {
  required TheSpeechToTextState state,
  required VoidCallback? onPressed,
}) {
  final (icon, color) = switch (state.type) {
    TheSpeechToTextStateType.notReady => (
      const Icon(Icons.mic_off),
      Colors.grey,
    ),
    TheSpeechToTextStateType.listening => (const Icon(Icons.mic), Colors.red),
    TheSpeechToTextStateType.finishing => (
      const Icon(Icons.mic),
      Colors.red.shade500,
    ),
    TheSpeechToTextStateType.idle => (const Icon(Icons.mic), Colors.grey),
  };

  return IconButton(onPressed: onPressed, icon: icon, color: color);
}
