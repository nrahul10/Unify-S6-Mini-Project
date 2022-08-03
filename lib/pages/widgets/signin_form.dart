import 'package:face_net_authentication/TheHomePage.dart';
import 'package:face_net_authentication/locator.dart';
import 'package:face_net_authentication/pages/home.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:face_net_authentication/pages/profile.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:face_net_authentication/pages/widgets/app_text_field.dart';
import 'package:face_net_authentication/services/camera.service.dart';
import 'package:flutter/material.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({Key key, this.user}) : super(key: key);
  final User user;

  final _passwordController = TextEditingController();
  final _cameraService = locator<CameraService>();

  Future _signIn(context, user) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 7.0, bottom: 8.0),
            child: Text(
              'NAME: ',
              style: TextStyle(fontSize: 13),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              user.user,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(left: 7.0, bottom: 8.0),
            child: Text(
              'DESCRIPTION: ',
              style: TextStyle(fontSize: 13),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              user.description,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                // AppTextField(
                //   controller: _passwordController,
                //   labelText: "Password",
                //   isPassword: true,
                // ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                AppButton(
                  text: 'OK',
                  onPressed: () async {
                    _signIn(context, user);
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
