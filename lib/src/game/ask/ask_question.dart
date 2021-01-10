import 'package:daily_challenge/src/Logger.dart';
import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AskQuestionProvider with ChangeNotifier {
  TextEditingController _questionController;
  int _formAnswerIndex;
  List<TextEditingController> _answerControllers;
  bool hasAnswer;

  int get formAnswerIndex => _formAnswerIndex;
  TextEditingController get questionController => _questionController;
  List<TextEditingController> get answerControllers => _answerControllers;

  void addAnswerController() {
    answerControllers.add(TextEditingController());
    notifyListeners();
  }

  void deleteAnswerController(int index) {
    if (answerControllers.length != 2) {
      print('delete index $index');
      answerControllers.removeAt(index);
      if ((_formAnswerIndex < index) && (_formAnswerIndex > 1)) {
        _formAnswerIndex = index - 1;
      }
      notifyListeners();
    }
  }

  Widget mapAnswerControllerListBuilder(context, paddingVertical, index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical / 2),
      child: Row(
        children: [
          Radio(
            groupValue: _formAnswerIndex,
            value: index,
            onChanged: (value) {
              print(value);
              _formAnswerIndex = value;
              notifyListeners();
            },
          ),
          Expanded(
            child: SizedBox(
              child: TextFormField(
                controller: _answerControllers[index],
                decoration: InputDecoration(
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
                Icons.close,
              ),
              onPressed: () {
                deleteAnswerController(index);
              }),
        ],
      ),
    );
  }

  void settingField() {
    _questionController = TextEditingController();
    _formAnswerIndex = 0;
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

class AskQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _appBarHeight = AppBar().preferredSize.height;
    double _textSize = _appBarHeight * 0.5;
    double _paddingHorizontal = 20;
    double _paddingVertical = 10;
    AskQuestionProvider askQuestionProvider =
        Provider.of<AskQuestionProvider>(context);
    final _formKey = GlobalKey<FormState>();
    print('ask q');
    return Scaffold(
      appBar: AppBarPages.appBarAskQuestion(context, _formKey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(_paddingHorizontal),
              child: Container(
                child: Form(
                  key: _formKey,
                  // key: askQuestionProvider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QUESTION',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: _textSize,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: _paddingVertical,
                            horizontal: _paddingHorizontal),
                        child: TextFormField(
                          autofocus: false,
                          controller: askQuestionProvider.questionController,
                          decoration: InputDecoration(
                            hintText: "Enter your question here",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your question';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                        'ANSWER',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: _textSize,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: _paddingVertical,
                            horizontal: _paddingHorizontal),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ChangeNotifierProvider.value(value:
                                askQuestionProvider,
                                child: Consumer<AskQuestionProvider>(
                                  builder: (context, value, child) =>
                                      ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.answerControllers.length,
                                    padding: EdgeInsets.symmetric(
                                        vertical: _paddingVertical),
                                    itemBuilder: (context, index) =>
                                        askQuestionProvider.mapAnswerControllerListBuilder(
                                            context, _paddingVertical, index),
                                  ),
                                ),
                              ),
                              OutlineButton(
                                onPressed: () {
                                  askQuestionProvider.addAnswerController();
                                  print('Controller Created');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Create new answer'),
                                    Icon(Icons.add)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _paddingVertical,
                              horizontal: _paddingHorizontal),
                          child: SingleChildScrollView(
                              child: Align(
                            alignment: Alignment.bottomRight,
                            child: Builder(
                              builder: (context) => RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Processing Data')));
                                  }
                                },
                                child: Text('SUBMIT'),
                              ),
                            ),
                          ))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
