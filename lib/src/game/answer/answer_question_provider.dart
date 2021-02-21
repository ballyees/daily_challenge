import 'dart:collection';
import 'dart:convert';

import 'package:daily_challenge/src/api_provider.dart';
import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/global_configure.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:flutter/material.dart';

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
    stack = PreferenceUtils.getInt(GlobalConfigure.stackKey, 0);
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
    // ///offline-test
    // return await ApiProvider.getQuestion().then((res){
    //     _questions = Queue.from(jsonDecode(res)[ApiProvider.responseKey]);
    //     return true;
    // });
    ///online
    return await ApiProvider.getQuestion().then((res){
      _questions = Queue.from(jsonDecode(res.body)[ApiProvider.responseKey]);
      return res.statusCode < 400;
    });
  }

  Future<bool> removeCurrentQuestion() async {
    var q = _questions.removeFirst();
    bool request;
    if(_questions.isEmpty){
      CustomLogger.log('empty question');
      request = await requestQuestion().then((value) => value);
    }else{
      request = await Future.value(true);
    }
    notifyListeners();
    return request;
  }

  Map getCurrentQuestion() {
    return _questions.first;
  }

  bool correctAnswer(bool isCorrect){
    print('prev: $stack');
    if(isCorrect){
      stack += isCorrect?1:0;
      PreferenceUtils.setInt(GlobalConfigure.stackKey, stack);
    }else{
      stack = 0;
      PreferenceUtils.setInt(GlobalConfigure.stackKey, stack);
    }
    print('current: $stack');
    return isCorrect;
  }

  Map onSubmit(){
    Map question = getCurrentQuestion();
    Map choice = question['choice'].elementAt(selectChoice);
    ApiProvider.postHistory(choice.keys.first, question['id']);
    Map correctChoice = (question['choice'] as List).where((element) => element[element.keys.first]).toList()[0];
    /// reset select item
    selectChoice = 0;
    correctAnswer(choice[choice.keys.first]);
    removeCurrentQuestion();

    return {'isCorrect': choice[choice.keys.first], 'correctChoice': correctChoice};
  }

  void notify(){
    notifyListeners();
  }

}
