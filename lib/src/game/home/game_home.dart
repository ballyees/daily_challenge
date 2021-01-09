import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:flutter/material.dart';

class GameHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 1.25;
    double _height = MediaQuery.of(context).size.height / 5;
    double _paddingTop = MediaQuery.of(context).size.height / 15;
    return Scaffold(
      appBar: AppBarPages.appBarGameHome(context),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(0, _paddingTop, 0, 0),
        child: Column(
          children: [
            SizedBox(
                height: _height * 2,
                width: _width,
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  child: Icon(
                    Icons.pause,
                    size: 35.0,
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.black38)
                  ),
                )),
            SizedBox(
              height: _height / 10,
            ),
            SizedBox(
              width: _width,
              child: OutlineButton(
                child: Text(
                  'Let\'s ask',
                ),
                onPressed: () {
                  CustomLogger.log('ask');
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
                  'Answer me',
                ),
                onPressed: () {
                  CustomLogger.log('Answer');
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
    );
  }
}
