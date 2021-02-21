import 'dart:math';
import 'dart:ui';

import 'package:daily_challenge/src/api_provider.dart';
import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:daily_challenge/src/game/answer/answer_question_provider.dart';
import 'package:daily_challenge/src/game/answer/report_question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerQuestion extends StatefulWidget {
  @override
  _AnswerQuestionState createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  @override
  Widget build(BuildContext context) {
    double _appBarHeight = AppBar().preferredSize.height;
    double _textHeaderSize = _appBarHeight * 0.5;
    double _textBodySize = _textHeaderSize * 0.6;
    double _paddingHorizontal = 20;
    double _paddingVertical = 10;
    AnswerQuestionProvider answerQuestionProvider =
        Provider.of<AnswerQuestionProvider>(context);
    print('answer page: create');
    return Scaffold(
        appBar: AppBarPages.appBarAnswerQuestion(context),
        body: ChangeNotifierProvider.value(
          value: answerQuestionProvider,
          child: FutureBuilder(
            future: answerQuestionProvider.requestQuestion(),
            builder: (context, snapshot) {
              CustomLogger.log('request has data: ${snapshot.hasData.toString()}');
              if (snapshot.hasData) {
                return Consumer<AnswerQuestionProvider>(
                  builder: (context, value, child) {
                    if (answerQuestionProvider.questions.isEmpty) {
                      return Container();
                    }
                    return _mapQuestion(
                        context,
                        value,
                        _textHeaderSize,
                        _textBodySize,
                        _paddingHorizontal,
                        _paddingVertical);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  Widget _mapQuestion(
      context,
      AnswerQuestionProvider answerQuestionProvider,
      textHeaderSize,
      textBodySize,
      paddingHorizontal,
      paddingVertical) {
    Map question = answerQuestionProvider.getCurrentQuestion();
    List choice = question[ApiProvider.choiceKey] as List;
    if (choice == null) {
      CustomLogger.log('call outline');
      answerQuestionProvider.removeCurrentQuestion();
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(paddingHorizontal),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'QUESTION',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: textHeaderSize,
                        ),
                      ),
                      Tooltip(
                        message: "SHOW HINT",
                        waitDuration: Duration(microseconds: 1),
                        child: RawMaterialButton(
                          child: Icon(Icons.info_outline),
                          shape: CircleBorder(),
                          onPressed: () {
                            showDialog(context: context, builder: (context) => BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: AlertDialog(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('HINT'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Transform.rotate(
                                      angle: pi,
                                      child: Icon(
                                          Icons.wb_incandescent
                                      ),
                                    )
                                  ],
                                ),
                                content: Text(question["hint"]??"No hint in this question"),
                                actions: [
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ),);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: paddingVertical,
                        horizontal: paddingHorizontal),
                    child: TextField(
                      enabled: false,
                      minLines: 1,
                      maxLines: 100,
                      controller: TextEditingController(
                          text: question[ApiProvider.questionKey]),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  Text(
                    'Answer',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: textHeaderSize,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: paddingVertical,
                          horizontal: paddingHorizontal),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: choice.length,
                        itemBuilder: (context, index) {
                          Map item = choice.elementAt(index) as Map;
                          return Row(
                            children: [
                              Radio(
                                value: index,
                                groupValue: answerQuestionProvider.selectChoice,
                                onChanged: (value) {
                                  answerQuestionProvider.selectChoice = value;
                                  print('changeVal');
                                  answerQuestionProvider.notify();
                                },
                              ),
                              Text(
                                item.keys.first,
                                style: TextStyle(fontSize: textBodySize),
                              )
                            ],
                          );
                        },
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text('Submit'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => _blurDialog(
                              context, answerQuestionProvider.onSubmit()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return ChangeNotifierProvider.value(value: null);
  }

  Widget _blurDialog(context, Map choice) {
    String message = (choice['correctChoice'] as Map).keys.first;
    String title = 'correct';
    if (choice['isCorrect']) {
      message += ' is answer';
    } else {
      title = 'incorrect';
      message = 'the answer is ' + message;
    }
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('REPORT'),
            onPressed: () {
              Navigator.of(context).pop();
              showDialog(context: context,
                builder: (context) => ReportQuestion(),);
            },
          ),
        ],
      ),
    );
  }
}
