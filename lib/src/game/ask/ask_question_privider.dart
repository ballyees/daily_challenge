import 'dart:convert';

import 'package:daily_challenge/src/api_provider.dart';
import 'package:daily_challenge/src/Logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class AskQuestionProvider with ChangeNotifier {
  TextEditingController _questionController;
  int _formAnswerIndex;
  List<TextEditingController> _answerControllers;
  bool _hasAnswer;

  int get formAnswerIndex => _formAnswerIndex;
  void setFormAnswerIndex(int value) {
    _formAnswerIndex = value;
    notifyListeners();
  }
  bool get hasAnswer => _hasAnswer;
  TextEditingController get questionController => _questionController;
  List<TextEditingController> get answerControllers => _answerControllers;
  void clearController(){
    _answerControllers.clear();
    _questionController.clear();
    _answerControllers = null;
    _questionController = null;
  }

  void setHasAnswer(bool isAnswerCall){
    _hasAnswer = isAnswerCall;
    notifyListeners();
  }

  Future<int> onSubmit() async {
    List _answer = [];
    print(_questionController.text);
    // ignore: unnecessary_statements, missing_return
    _answerControllers.asMap().forEach((index, controller) {
      _answer.add({controller.text: _formAnswerIndex==index});
    });
    Response response = await post(ApiProvider.questionApi, body: jsonEncode({'question': _questionController.text, 'choice': _answer}));
    _formAnswerIndex = 0;
    clearController();
    settingField();
    notifyListeners();
    return response.statusCode;
  }

  void addAnswerControllerAnimation(GlobalKey<AnimatedListState> listKey) {
    answerControllers.add(TextEditingController());
    listKey.currentState.insertItem(answerControllers.length - 1);
    CustomLogger.log('Controller Created');
    notifyListeners();
  }

  void deleteAnswerControllerAnimation(context, int index, deleteDuration, paddingVertical, GlobalKey<AnimatedListState> listKey) {
    if (answerControllers.length > 2) {
      CustomLogger.log('delete index: $index');
      TextEditingController controller = answerControllers.removeAt(index);
      listKey.currentState.removeItem(index, (context, animation) => _mapAnswerControllerAnimationRemove(context, paddingVertical, animation, controller));
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: deleteDuration),
          content: Text("answer ${index + 1}: ${controller.text} remove")));

      if ((_formAnswerIndex <= index) && (_formAnswerIndex > 1)) {
        _formAnswerIndex = index - 1;
      }
      notifyListeners();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: deleteDuration),
          content: Text("can't remove the answer")));
    }
  }

  Widget _mapAnswerControllerAnimationRemove(context, paddingVertical, Animation<double> animation, TextEditingController controller){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: ScaleTransition(
        scale: animation,
        child: Row(
          children: [
            Radio(
              groupValue: _formAnswerIndex,
              onChanged: (value) {
              },
            ),
            Expanded(
              child: SizedBox(
                child: TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    // setHasAnswer(true);
                    // notifyListeners();
                  },
                  decoration: InputDecoration(
                    suffixIcon: controller.text != ''
                        ? IconButton(
                      onPressed: () {
                      },
                      icon: Icon(Icons.clear),
                    )
                        : null,
                    hintText: "Enter your answer here",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your answer';
                    }
                    return null;
                  },
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                }),
          ],
        ),
      ),
    );
  }

  void clearAnswerController(int index) {
    answerControllers[index].clear();
    notifyListeners();
  }

  void clearQuestionController() {
    questionController.clear();
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }

  void settingField() {
    _questionController = TextEditingController();
    _formAnswerIndex = 0;
    _hasAnswer = false;
    _answerControllers = <TextEditingController>[
      TextEditingController(),
      TextEditingController()
    ];
  }

  static final AskQuestionProvider _instance = AskQuestionProvider._internal();
  factory AskQuestionProvider() {
    CustomLogger.log('ask_question provider: singleton factory');
    return _instance;
  }
  AskQuestionProvider._internal() {
    settingField();
    CustomLogger.log('ask_question provider: singleton created');
  }
  @override
  void dispose() {
    CustomLogger.log('call dummy dispose');
  }
}