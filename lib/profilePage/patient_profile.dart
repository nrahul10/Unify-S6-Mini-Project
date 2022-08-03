import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:face_net_authentication/patient.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String age = '';
  String bloodGroup = '';
  String emergencyContact = '';
  String gender = '';
  String about = '';
  @override
  void initState() {
    super.initState();
    loadProfileInfo();
  }

  void loadProfileInfo() {
    patient.loadInfo();
    name = patient.name;
    age = patient.age;
    bloodGroup = patient.bloodGroup;
    emergencyContact = patient.emergencyContact;
    gender = patient.gender;
    about = patient.about;
  }

  void saveProfileInfo() {
    patient.name = name;
    patient.age = age;
    patient.bloodGroup = bloodGroup;
    patient.emergencyContact = emergencyContact;
    patient.gender = gender;
    patient.about = about;
    patient.saveInfo();
  }

  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.pink, // Color for Android
    ));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // color: Colors.pink,
                width: double.infinity,
                // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.pink,
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

                child: Text(
                  'PROFILE',
                  textScaleFactor: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(color: Colors.white),
                  // style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextField(
                  controller: controller
                    ..text = name
                    ..selection = TextSelection.collapsed(offset: name.length),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Name',
                    hintText: 'Enter Name',
                  ),
                  onChanged: (text) {
                    name = text;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: TextEditingController()
                          ..text = bloodGroup
                          ..selection = TextSelection.collapsed(
                              offset: bloodGroup.length),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: 'Blood Group',
                          hintText: 'Enter Blood Group',
                        ),
                        onChanged: (text) {
                          bloodGroup = text;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: TextField(
                        controller: TextEditingController()
                          ..text = age
                          ..selection =
                              TextSelection.collapsed(offset: age.length),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: 'Age',
                          hintText: 'Enter Age',
                        ),
                        onChanged: (text) {
                          age = text;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextField(
                  controller: TextEditingController()
                    ..text = emergencyContact
                    ..selection = TextSelection.collapsed(
                        offset: emergencyContact.length),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Emergency Contact',
                    hintText: 'Enter Emergency Contact',
                  ),
                  onChanged: (text) {
                    emergencyContact = text;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: TextField(
                  controller: TextEditingController()..text = about,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'About',
                    hintText: 'Enter About Yourself',
                  ),
                  onChanged: (text) {
                    about = text;
                  },
                ),
              ),
              // ElevatedButton(
              //   onPressed: saveProfileInfo,
              //   child: Text('SAVE'),
              //   style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              // ),

              // Material(
              //   color: Colors.deepOrangeAccent,
              //   borderRadius: BorderRadius.circular(50),
              //   child: InkWell(
              //     onTap: () {
              //       saveProfileInfo();
              //     },
              //     borderRadius: BorderRadius.circular(50),
              //     child: Container(
              //       width: 300,
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       height: 50,
              //       alignment: Alignment.center,
              //       child: Text(
              //         'SAVE',
              //         style: GoogleFonts.oswald(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    saveProfileInfo();
                  },
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.deepOrangeAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
