import 'package:flutter/widgets.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state.dart';

typedef TheSpeechToTextButtonBuilder =
    Widget Function(
      BuildContext context, {
      required TheSpeechToTextState state,
      required VoidCallback? onPressed,
    });
