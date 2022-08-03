import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecogn extends StatefulWidget {
  SpeechRecogn({Key key}) : super(key: key);

  @override
  _SpeechRecognState createState() => _SpeechRecognState();
}

class _SpeechRecognState extends State<SpeechRecogn> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = 'Words will appear here ...';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigoAccent, // Color for Android
    ));
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     // Status bar color
      //     statusBarColor: Colors.blue,
      //     statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      //     statusBarBrightness: Brightness.light, // For iOS (dark icons)
      //   ),
      //   title: Text('Speech To Text'),
      // ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.indigoAccent,
                      offset: Offset(0, 3.5),
                    )
                  ],
                ),
                // borderRadius: BorderRadius.all(Radius.circular(30))),
                padding: EdgeInsets.fromLTRB(20, 25, 20, 25),

                child: Text(
                  'Speech To Text',
                  textScaleFactor: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(color: Colors.white),
                  // style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  'Recognized words:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        // If listening is active show the recognized words
                        _speechToText.isListening
                            ? 'Listening...'
                            // If listening isn't active but could be tell the user
                            // how to start it, otherwise indicate that speech
                            // recognition is not yet ready or not supported on
                            // the target device
                            : _speechEnabled
                                ? 'Tap the microphone to start listening...'
                                : 'Speech not available',
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 350,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        // color: Color(0xFFFDEDD2),
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '$_lastWords',
                        textScaleFactor: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        backgroundColor: Colors.indigoAccent,
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
