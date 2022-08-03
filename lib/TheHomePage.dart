import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:face_net_authentication/FaceRecognitionPage/face_recognition_page.dart';
import 'package:face_net_authentication/FaceRecognitionPage/FaceMatchingPage.dart';
import 'package:face_net_authentication/profilePage/patient_profile.dart';
import 'package:flutter/material.dart';
import 'package:face_net_authentication/SpeechToTextPage/speech_to_text_page.dart';
import 'package:face_net_authentication/SosPage/sos_page.dart';
import 'package:face_net_authentication/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:face_net_authentication/pages/home.dart';
import 'package:flutter/services.dart';
import 'remain.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`

  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nameTitle = 'Devan';
  double picHPadding = 16.0;

  @override
  void initState() {
    super.initState();
    patient.initState();
  }
  //
  //
  // Future<void> loadName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   patient.loadInfo();
  //   nameTitle = patient.name;
  //   setState(() {
  //     // _emergencyInfoString = prefs.getString('emergencyInfoString')!;
  //     patient.loadInfo();
  //     nameTitle = patient.name;
  //     print('Patient name is ' + patient.name);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.pink,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color(0xFFFDEDD2),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              //Custom App bar using Widget
              Container(
                // height: 50,

                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  // borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.pinkAccent,
                      offset: Offset(0, 3.5),
                    )
                  ],
                ),
                // borderRadius: BorderRadius.all(Radius.circular(30))),
                padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                    ),
                    Container(
                      child: Text(
                        'Unify',
                        textScaleFactor: 2,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile())).then(
                          (_) => setState(() {}),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage('images/appIcon02.png'),
                        // backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin: EdgeInsets.only(
                        bottom: 10.0, top: 20, left: 16, right: 16),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Welcome, ' + patient.name,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: picHPadding, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage())).then(
                          (_) => setState(() {}),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('images/facetext.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: picHPadding, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MedicineReminder())).then(
                          (_) => setState(() {}),
                        );

                        // launch('https://calendar.google.com/calendar');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('images/remindertext.jpeg'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: picHPadding, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SosApp())).then(
                          (_) => setState(() {}),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('images/sostext.jpeg'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(
                        horizontal: picHPadding, vertical: 8.0),
                    // EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpeechRecogn())).then(
                          (_) => setState(() {}),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('images/speechToTextImage.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
