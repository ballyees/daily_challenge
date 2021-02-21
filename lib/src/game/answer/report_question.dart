import 'dart:ui';
import 'package:flutter/material.dart';

class ReportQuestionProvider {
  static List<String> reportQuestionItem = ["wrong hint", "wrong answer"];
  static String dropdownVal =
  ReportQuestionProvider.reportQuestionItem.elementAt(0);
  static Map functionMapping = {};

}

enum status { onLoad }

class ReportQuestion extends StatefulWidget {
  ReportQuestion({Key key}) : super(key: key);

  @override
  _ReportQuestionState createState() => _ReportQuestionState();
}

class _ReportQuestionState extends State<ReportQuestion> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(status.onLoad.toString());
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        title: Text('QUESTION REPORT'),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton(
                          isExpanded: true,
                          value: ReportQuestionProvider.dropdownVal,
                          items: ReportQuestionProvider.reportQuestionItem
                              .map((e) => DropdownMenuItem(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  e,
                                )),
                            value: e,
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              ReportQuestionProvider.dropdownVal = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('DETAIL', style: TextStyle(
                            fontSize: 20
                        ),),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 100,
                            controller: _controller,
                            decoration: InputDecoration(
                              suffixIcon: _controller.text !=
                                  ''
                                  ? IconButton(
                                onPressed: () {
                                  _controller.clear();
                                },
                                icon: Icon(Icons.clear),
                              )
                                  : null,
                              hintText: "Enter your detail here",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          FlatButton(
            child: Text('submit'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}