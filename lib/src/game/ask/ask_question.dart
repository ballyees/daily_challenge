import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:daily_challenge/src/game/ask/ask_question_privider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AskQuestion extends StatefulWidget {
  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _appBarHeight = AppBar().preferredSize.height;
    double _textSize = _appBarHeight * 0.5;
    double _paddingHorizontal = 20;
    double _paddingVertical = 10;
    AskQuestionProvider askQuestionProvider =
        Provider.of<AskQuestionProvider>(context);
    print('ask question: create');
    return Scaffold(
      appBar: AppBarPages.appBarAskQuestion(context, _formKey),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(_paddingHorizontal),
              child: Container(
                child: Form(
                  key: _formKey,
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
                        child: ChangeNotifierProvider.value(
                          value: askQuestionProvider,
                          child: Consumer<AskQuestionProvider>(
                            builder: (context, value, child) => TextFormField(
                              autofocus: !(askQuestionProvider.hasAnswer),
                              onChanged: (value) {
                                print(askQuestionProvider.hasAnswer);
                                askQuestionProvider.notify();
                              },
                              controller:
                                  askQuestionProvider.questionController,
                              decoration: InputDecoration(
                                suffixIcon: askQuestionProvider
                                            .questionController.text !=
                                        ''
                                    ? IconButton(
                                        onPressed: () {
                                          askQuestionProvider
                                              .clearQuestionController();
                                        },
                                        icon: Icon(Icons.clear),
                                      )
                                    : null,
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
                              ChangeNotifierProvider.value(
                                value: askQuestionProvider,
                                child: Consumer<AskQuestionProvider>(
                                  builder: (context, value, child) =>
                                      //     ListView.builder(
                                      //   shrinkWrap: true,
                                      //   itemCount: value.answerControllers.length,
                                      //   itemBuilder: (context, index) =>
                                      //       askQuestionProvider
                                      //           .mapAnswerControllerListBuilder(
                                      //               context,
                                      //               _paddingVertical,
                                      //               index),
                                      // ),
                                      AnimatedList(
                                        controller: ScrollController(
                                          initialScrollOffset: 2
                                        ),
                                    shrinkWrap: true,
                                    key: _listKey,
                                    initialItemCount:
                                        value.answerControllers.length,
                                    itemBuilder: (context, index, animation) =>
                                        value
                                            .mapAnswerControllerAnimationBuilder(
                                                context,
                                                _paddingVertical,
                                                index,
                                                animation,
                                                value.answerControllers[index],
                                                _listKey),
                                  ),
                                ),
                              ),
                              OutlineButton(
                                onPressed: () {
                                  // askQuestionProvider.addAnswerController();
                                  askQuestionProvider
                                      .addAnswerControllerAnimation(_listKey);
                                  // Custom('Controller Created');
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
                                    askQuestionProvider.onSubmit();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AskQuestion(),
                                    ));
                                  }
                                },
                                child: Text('SUBMIT'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
