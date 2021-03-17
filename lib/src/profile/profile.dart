import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:daily_challenge/src/profile/profile_provider.dart';
import 'package:daily_challenge/src/register/Register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 1.25;
    double _height = MediaQuery.of(context).size.height / 5;
    double _paddingHorizontal = 20;
    double _appBarHeight = AppBar().preferredSize.height;
    double _textHeaderSize = _appBarHeight * 0.5;
    double _textBodySize = _textHeaderSize * 0.6;

    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBarPages.appBarGameHome(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(_paddingHorizontal),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                    height: _height,
                    width: _width,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen(),));
                      },
                      elevation: 2.0,
                      child: Icon(
                        Icons.account_circle,
                        size: _height,
                      ),
                      shape:
                          CircleBorder(side: BorderSide(color: Colors.black38)),
                    )),
                SizedBox(
                  height: _height / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PROFILE',
                      style: TextStyle(
                        fontSize: _textHeaderSize,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height / 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'GUEST : ${profileProvider.userId.substring(0, 8)}',
                        style: TextStyle(fontSize: _textBodySize),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height / 10,
                ),
                SizedBox(
                  width: _width,
                  child: OutlineButton(
                    child: Text(
                      'LOG IN',
                    ),
                    onPressed: () {
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height / 10,
                ),
                SizedBox(
                  width: _width,
                  child: OutlineButton(
                    child: Text(
                      'REGISTER',
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.black38),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
