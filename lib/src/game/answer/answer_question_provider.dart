import 'dart:collection';
import 'dart:convert';

import 'package:daily_challenge/src/ApiConfigure.dart';
import 'package:daily_challenge/src/Logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AnswerQuestionProvider with ChangeNotifier {
  static final AnswerQuestionProvider _instance =
      AnswerQuestionProvider._internal();
  Queue _questions;
  int selectChoice;
  int stack;
  Queue get questions => _questions;

  factory AnswerQuestionProvider() {
    CustomLogger.log('AnswerQuestionProvider: singleton factory');
    return _instance;
  }

  AnswerQuestionProvider._internal() {
    _questions = Queue();
    selectChoice = 0;
    stack = 0;
    CustomLogger.log('AnswerQuestionProvider: singleton created');
  }

  void refreshQuestion(){
    _questions.clear();
    requestQuestion();
    notifyListeners();
  }

  Future<bool> requestQuestion() async {
    // print('is empty q: ${_questions.isEmpty}');
    if(_questions.isNotEmpty){
      return true;
    }
    return await ApiConfigure.getQuestion().then((res){
      _questions = Queue.from(jsonDecode(res.body)[ApiConfigure.responseKey]);
      return res.statusCode < 400;
    });
    // return await get(ApiConfigure.questionApiLimit).then((res) {
    //   _questions = Queue.from(jsonDecode(res.body)[ApiConfigure.responseKey]);
    //   return res.statusCode < 400;
    // });
  }

  Future<bool> removeCurrentQuestion() async {
    _questions.removeFirst();
    bool request = true;
    if(_questions.isEmpty){
      CustomLogger.log('empty question');
      request = await requestQuestion().then((value) => value);
    }
    notifyListeners();
    return request;

  }

  Map getCurrentQuestion() {
    return _questions.first;
  }

  Map onSubmit(){
    Map question = getCurrentQuestion();
    Map choice = question['choice'].elementAt(selectChoice);
    Map correctChoice = (question['choice'] as List).where((element) => element[element.keys.first]).toList()[0];
    removeCurrentQuestion();
    /// reset select item
    selectChoice = 0;
    return {'isCorrect': choice[choice.keys.first], 'correctChoice': correctChoice};
  }

  void notify(){
    notifyListeners();
  }

}
