import 'package:flutter/material.dart';
import 'package:the_speech_to_text_button/the_speech_to_text_button.dart';

void main() {
  runApp(const ExampleApp());
}

/// The example app
class ExampleApp extends StatelessWidget {
  /// Create a new example app
  const ExampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Speech to text button demo',
      home: MyHomePage(),
    );
  }
}

/// The home page
class MyHomePage extends StatefulWidget {
  /// Create a new home page
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// The state of the home page
class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Speech to text button demo'),
      ),
      body: Column(
        children: [
          TextField(controller: _textController, minLines: 10, maxLines: 10),
          TheSpeechToTextButton(
            onResult: (result) {
              _textController.text = result.text;
            },
            askPermissionDialogBuilder: askPermissionDialogBuilder,
          ),
        ],
      ),
    );
  }

  void askPermissionDialogBuilder(void Function()? onOpenSettings) {
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Permission required'),
            content: const Text(
              'Please enable microphone and speech recognition',
            ),
            actions: [
              if (onOpenSettings != null)
                TextButton(
                  onPressed: onOpenSettings,
                  child: const Text('Open settings'),
                ),
            ],
          ),
    );
  }
}
