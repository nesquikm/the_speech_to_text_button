import 'package:flutter/material.dart';
import 'package:the_speech_to_text_button/the_speech_to_text_button.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to text button demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Speech to text button demo'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(controller: _textController, minLines: 10, maxLines: 10),
            TheSpeechToTextButton(
              onResult: (result) {
                _textController.text = result.text;
              },
              askPermissionDialogBuilder: (onOpenSettings) {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
