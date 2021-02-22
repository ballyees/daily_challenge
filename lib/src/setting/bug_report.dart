import 'package:daily_challenge/src/appbar/appbar.dart';
import 'package:flutter/material.dart';

class BugReportPage extends StatefulWidget {
  BugReportPage({Key key}) : super(key: key);

  @override
  _BugReportPageState createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _appBarHeight = AppBar().preferredSize.height;
    double _textHeaderSize = _appBarHeight * 0.5;
    double _textBodySize = _textHeaderSize * 0.6;
    double _paddingHorizontal = 20;
    double _paddingVertical = 10;
    return Scaffold(
      appBar: AppBarPages.appBarBugReport(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('BUG REPORT', style: TextStyle(
                        fontSize: _textHeaderSize
                      ),),
                    ],
                  ),
                  SizedBox(height: _paddingVertical,),
                  Row(
                    children: [
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: TextFormField(
                            minLines: 10,
                            maxLines: 100,
                            controller: _controller,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your question';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: _controller.text != ''
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
                  SizedBox(height: _paddingVertical,),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            child: Text('Submit'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}