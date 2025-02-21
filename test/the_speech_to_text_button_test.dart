import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_speech_to_text_button/the_speech_to_text_button.dart';

void main() {
  testWidgets('TheSpeechToTextButton renders using default builder', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: TheSpeechToTextButton()));
    expect(find.byType(TheSpeechToTextButton), findsOneWidget);
    expect(find.byIcon(Icons.mic_off), findsOneWidget);
  });

  testWidgets('TheSpeechToTextButton renders using custom builder', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TheSpeechToTextButton(
          builder:
              (BuildContext context, {required state, required onPressed}) =>
                  TextButton(
                    onPressed: onPressed,
                    child: Text(state.type.name),
                  ),
        ),
      ),
    );
    expect(find.byType(TheSpeechToTextButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text('notReady'), findsOneWidget);
  });
}
