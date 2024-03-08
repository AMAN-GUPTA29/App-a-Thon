import 'dart:ffi';

import 'package:agri_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Talkbot extends StatefulWidget {
  const Talkbot({super.key});

  @override
  State<Talkbot> createState() => _TalkbotState();
}

class _TalkbotState extends State<Talkbot> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = '';
  double _confidenceLevel = 0.0;
  String responseText = '';
  final apiService = ApiService();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {
      // Empty setState to refresh the widget
    });
  }

  void _onSpeechResult(result) async {
    setState(() {
      _wordsSpoken = '${result.recognizedWords}';
      _confidenceLevel = result.confidence;
    });
    if (_speechToText.isNotListening) {
      GenerateContentResponse temp2 =
          await apiService.sendMessageGemini(text: result.recognizedWords);
      setState(() {
        responseText = temp2.text!;
      });
    }
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _showErrorSnackBar(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          'Talk with Kisan Mitra',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? 'Listening...'
                    : _speechEnabled
                        ? 'Tap the mic to start listening...'
                        : 'Speech not available',
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _wordsSpoken,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Container(padding: EdgeInsets.all(16), child: Text(responseText)),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Container(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "Confidence : ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w200),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        tooltip: 'Listen',
        backgroundColor: Colors.lightGreen,
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
