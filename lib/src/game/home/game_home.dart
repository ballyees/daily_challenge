import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:daily_challenge/src/game/answer/answer_question.dart';
import 'package:daily_challenge/src/game/ask/ask_question.dart';
import 'package:flutter/material.dart';

class GameHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 1.25;
    double _height = MediaQuery.of(context).size.height / 5;
    double _paddingHorizontal = 20;
    return Scaffold(
      appBar: AppBarPages.appBarGameHome(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(_paddingHorizontal),
          child: Container(
            alignment: Alignment.topCenter,
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
                      // Navigator.push(context,
                      // createAnimationPageRoute(pageRoute: AskQuestion())
                      // );
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => AskQuestion(),
                      ),
                      );
                      CustomLogger.log('Ask');
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
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AnswerQuestion(),
                      ));
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
        ),
      ),
    );
  }
}
