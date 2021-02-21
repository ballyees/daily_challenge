import 'package:flutter/material.dart';

class BugReport extends StatefulWidget {
  BugReport({Key key}) : super(key: key);

  @override
  _BugReportState createState() => _BugReportState();
}

class _BugReportState extends State<BugReport> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
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
                Row(
                  children: [
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: TextFormField(
                          minLines: 1,
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
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text('Submit'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}