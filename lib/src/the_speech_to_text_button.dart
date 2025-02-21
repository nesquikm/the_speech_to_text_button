import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:the_speech_to_text_button/src/default_builder.dart';
import 'package:the_speech_to_text_button/src/speech_recognition_error_extension.dart';
import 'package:the_speech_to_text_button/src/speech_recognition_result_extension.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state.dart';
import 'package:the_speech_to_text_button/src/the_speech_to_text_state_extension.dart';
import 'package:the_speech_to_text_button/the_speech_to_text_button.dart';

/// The speech to text button
class TheSpeechToTextButton extends StatefulWidget {
  /// Create a new speech to text button
  const TheSpeechToTextButton({
    super.key,
    this.builder = defaultBuilder,
    this.onResult,
    this.onStateChange,
    this.controller,
    this.askPermissionDialogBuilder,
    this.localeId,
  });

  /// The builder for the speech to text button
  final TheSpeechToTextButtonBuilder builder;

  /// The on result callback
  final void Function(TheSpeechToTextResult result)? onResult;

  /// The on state change callback
  final void Function(TheSpeechToTextState state)? onStateChange;

  /// The ask permission dialog builder
  final void Function(void Function()? onOpenSettings)?
  askPermissionDialogBuilder;

  /// The controller for the speech to text button
  final TheSpeechToTextButtonController? controller;

  /// The locale id
  final String? localeId;

  @override
  State<TheSpeechToTextButton> createState() => _TheSpeechToTextButtonState();
}

class _TheSpeechToTextButtonState extends State<TheSpeechToTextButton>
    with WidgetsBindingObserver {
  TheSpeechToTextButtonController? _controller;

  TheSpeechToTextButtonController get _effectiveController =>
      widget.controller ?? (_controller ??= TheSpeechToTextButtonController());

  late final _speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();

    _initController();

    _onCheckPermissions(false);
  }

  @override
  void didUpdateWidget(TheSpeechToTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _disposeController();
      _initController();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onCheckPermissions(false);
    }
  }

  @override
  void dispose() {
    _disposeController();

    super.dispose();
  }

  void _initController() {
    _effectiveController.onCheckPermissions.addListener(
      _onCheckPermissionsCallback,
    );
    _effectiveController.onStart.addListener(_onStartCallback);
    _effectiveController.onStop.addListener(_onStopCallback);
    _effectiveController.addListener(_onStateChangeCallback);
  }

  void _disposeController() {
    _effectiveController.onCheckPermissions.removeListener(
      _onCheckPermissionsCallback,
    );
    _effectiveController.onStart.removeListener(_onStartCallback);
    _effectiveController.onStop.removeListener(_onStopCallback);
    _effectiveController.removeListener(_onStateChangeCallback);
    _controller?.dispose();
    _controller = null;
  }

  void _onStateChangeCallback() {
    widget.onStateChange?.call(_effectiveController.value);
  }

  void _onCheckPermissionsCallback() {
    _onCheckPermissions(_effectiveController.onCheckPermissions.value);
  }

  Future<bool> _onCheckPermissions(bool askIfNeeded) async {
    final permissionStatus =
        askIfNeeded
            ? [
              await Permission.microphone.request(),
              if (!kIsWeb) await Permission.speech.request(),
            ]
            : [
              await Permission.microphone.status,
              if (!kIsWeb) await Permission.speech.status,
            ];

    if (permissionStatus.every((status) => status.isGranted)) {
      _effectiveController.value =
          _effectiveController.value.clearPermissionError();

      final isReady = await _onSpeechToTextInitialize();

      if (isReady) {
        _effectiveController.value =
            _effectiveController.value.setInitialized();
      }

      return isReady;
    }

    final isPermanentlyDenied = permissionStatus.any(
      (status) => status.isPermanentlyDenied,
    );

    _effectiveController.value = _effectiveController.value.withPermissionError(
      isPermanentlyDenied: isPermanentlyDenied,
    );

    if (!askIfNeeded) {
      return false;
    }

    final onOpenSettings =
        isPermanentlyDenied && !kIsWeb ? _onOpenSettings : null;

    widget.askPermissionDialogBuilder?.call(onOpenSettings);

    return false;
  }

  void _onOpenSettings() {
    openAppSettings();
  }

  Future<bool> _onSpeechToTextInitialize() async {
    return _speechToText.initialize(
      onError: (error) {
        _effectiveController.value = _effectiveController.value.withError(
          TheSpeechToTextError(type: error.toSpeechToTextErrorType),
        );
      },
      onStatus: (status) {
        _effectiveController.value = _effectiveController.value.withStatus(
          switch (status) {
            'listening' => TheSpeechToTextStateType.listening,
            'notListening' => TheSpeechToTextStateType.finishing,
            'done' => TheSpeechToTextStateType.idle,
            _ => TheSpeechToTextStateType.idle,
          },
        );
      },
    );
  }

  void _onStartCallback() {
    _onStart();
  }

  void _onStopCallback() {
    _onStop();
  }

  Future<void> _onStart() async {
    if (!(await _onCheckPermissions(true))) {
      return;
    }

    await _speechToText.listen(
      localeId: widget.localeId,
      onResult: (result) {
        widget.onResult?.call(result.toSpeechToTextResult);
      },
    );
  }

  void _onStop() {
    if (_speechToText.isListening) {
      _speechToText.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _effectiveController,
      builder: (BuildContext context, value, Widget? child) {
        final onPressed = switch (value.type) {
          TheSpeechToTextStateType.idle => _onStart,
          TheSpeechToTextStateType.listening => _onStop,
          TheSpeechToTextStateType.notReady => _onStart,
          TheSpeechToTextStateType.finishing => null,
        };

        return widget.builder(context, onPressed: onPressed, state: value);
      },
    );
  }
}
