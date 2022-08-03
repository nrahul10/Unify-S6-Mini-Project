import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:face_net_authentication/patient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class SosApp extends StatefulWidget {
  const SosApp({Key key}) : super(key: key);

  @override
  State<SosApp> createState() => SosAppState();
}

class SosAppState extends State<SosApp> {
  String emergencyInfoString = 'EmptySOS';

  @override
  void initState() {
    super.initState();
    _loadEmergencyInfo();
  }

  //Loading counter value on start
  Future<void> _loadEmergencyInfo() async {
    // final prefs = await SharedPreferences.getInstance();
    patient.loadInfo();
    setState(() {
      emergencyInfoString = patient.name;
    });
  }

  Future<void> _saveEmergencyInfo() async {
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      patient.name = emergencyInfoString;
      print('Patient name is :' + patient.name);
      patient.saveInfo();
      // prefs.setString('emergencyInfoString', _emergencyInfoString);
    });
  }

  Future _sendSMS(String message, List<String> recipents) async {
    String result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(result);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // final Uri launchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    String telephoneUrl = "tel:$phoneNumber";
    await launch(telephoneUrl);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xFFE53935), // Color for Android
    ));
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.pink,
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFE53935),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.redAccent,
                      offset: Offset(0, 3.5),
                    )
                  ],
                ),
                // borderRadius: BorderRadius.all(Radius.circular(30))),
                padding: EdgeInsets.fromLTRB(20, 25, 20, 25),

                child: Text(
                  'SOS',
                  textScaleFactor: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(color: Colors.white),
                  // style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFDEDD2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth(),
                      },
                      // border: TableBorder.all(),
                      children: <TableRow>[
                        TableRow(
                          children: [
                            Text(
                              'Name:\n',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              patient.name,
                              textScaleFactor: 1.25,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'Blood Group:\n',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              patient.bloodGroup,
                              textScaleFactor: 1.25,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'Age:\n',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              patient.age,
                              textScaleFactor: 1.25,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'Emergency Contact:\n',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              patient.emergencyContact,
                              textScaleFactor: 1.25,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'About:',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              patient.about,
                              textScaleFactor: 1.1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Expanded(child: Container()),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // for getting position
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);

                    // Navigator.pop(context);

                    String message =
                        "SOS! Message from ${patient.name}. I need help! Location:"
                        " https://www.google.com/maps/@${position.latitude},${position.longitude},21z ";
                    // String message = "SOS! Message from Devan. I need help!";
                    List<String> recipents = [patient.emergencyContact];

                    _sendSMS(message, recipents);
                  },
                  child: Text(
                    'SEND SOS MESSAGE',
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    _makePhoneCall(patient.emergencyContact);
                  },
                  child: Text(
                    'SOS CALL',
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
