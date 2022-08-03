import 'package:face_net_authentication/TheHomePage.dart';
import 'package:face_net_authentication/constants/constants.dart';
import 'package:face_net_authentication/locator.dart';
import 'package:face_net_authentication/pages/db/databse_helper.dart';
import 'package:face_net_authentication/pages/sign-in.dart';
import 'package:face_net_authentication/pages/sign-up.dart';
import 'package:face_net_authentication/services/camera.service.dart';
import 'package:face_net_authentication/services/ml_service.dart';
import 'package:face_net_authentication/services/face_detector_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MLService _mlService = locator<MLService>();
  FaceDetectorService _mlKitService = locator<FaceDetectorService>();
  CameraService _cameraService = locator<CameraService>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    setState(() => loading = true);
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
    setState(() => loading = false);
  }

  void _launchURL() async => await canLaunch(Constants.githubURL)
      ? await launch(Constants.githubURL)
      : throw 'Could not launch ${Constants.githubURL}';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Color(0xFF0F0BDB) // Color for Android
            ));
    return Scaffold(
      // appBar: AppBar(
      //   leading: Container(
      //     height: 20,
      //     color: Colors.yellow,
      //     width: double.infinity,
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.only(right: 20, top: 20),
      //       child: PopupMenuButton<String>(
      //         child: Icon(
      //           Icons.more_vert,
      //           color: Colors.black,
      //         ),
      //         onSelected: (value) {
      //           switch (value) {
      //             case 'Clear DB':
      //               DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
      //               _dataBaseHelper.deleteAll();
      //               break;
      //           }
      //         },
      //         itemBuilder: (BuildContext context) {
      //           return {'Clear DB'}.map((String choice) {
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Text(choice),
      //             );
      //           }).toList();
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: !loading
          ? SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF0F0BDB),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Color(0xFF0F0BDB),
                              offset: Offset(0, 3.5),
                            )
                          ],
                        ),
                        // borderRadius: BorderRadius.all(Radius.circular(30))),
                        padding: EdgeInsets.fromLTRB(20, 25, 20, 25),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                            Text(
                              'Face Recognition',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                              // style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              // padding: EdgeInsets.only(right: 8, top: 20),
                              child: PopupMenuButton<String>(
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                onSelected: (value) {
                                  switch (value) {
                                    case 'Clear DB':
                                      DatabaseHelper _dataBaseHelper =
                                          DatabaseHelper.instance;
                                      _dataBaseHelper.deleteAll();
                                      break;
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return {'Clear DB'}.map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Image(image: AssetImage('assets/logo.png'),),
                      Container(
                        height: 275,
                        child: Image(
                          image: AssetImage('images/recoImg.png'),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "SCAN AND IDENTIFY",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Scan the user to Identify who it is and to see information about them",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => SignIn(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.1),
                                        blurRadius: 1,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 100,
                                  padding: EdgeInsets.all(20),
                                  // width:
                                  //     MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF0F0BDB),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'SCAN',
                                        style:
                                            TextStyle(color: Color(0xFF0F0BDB)),
                                      ),

                                      // Icon(Icons.login, color: Color(0xFF0F0BDB))
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignUp(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF0F0BDB),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.1),
                                          blurRadius: 1,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(20),
                                    width: 150,
                                    height: 100,
                                    // width:
                                    //     MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person_add,
                                            color: Colors.white),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ADD PERSON',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
