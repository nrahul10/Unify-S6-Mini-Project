import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Patient {
  String name = 'Devan';
  String age = '72';
  String bloodGroup = 'B+ve';
  String emergencyContact = '9562494783';
  String gender = 'Male';
  String about =
      'I am a patient suffering from Geriatric Cognitive and Locomotor disability';
  TimeOfDay gTime = TimeOfDay.now();
  void initState() {
    loadInfo();
    print('=========Loaded Patient Info , PatientName: $name');
  }

  Patient() {
    loadInfo();
  }
  Future<void> loadInfo() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    age = prefs.getString('age') ?? '';
    bloodGroup = prefs.getString('bloodGroup') ?? '';
    emergencyContact = prefs.getString('emergencyContact') ?? '';
    gender = prefs.getString('gender') ?? '';
    about = prefs.getString('about') ?? '';
  }

  Future<void> saveInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('age', age);
    prefs.setString('bloodGroup', bloodGroup);
    prefs.setString('emergencyContact', emergencyContact);
    prefs.setString('gender', gender);
    prefs.setString('about', about);
  }
// loadInfo();
}

Patient patient = Patient();
