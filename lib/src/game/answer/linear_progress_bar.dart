import 'dart:async';
import 'package:daily_challenge/src/game/status.dart';
import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {

  int durations;
  int times = 1000;
  bool isNew = true;
  double decrement;
  Status status;
  LinearProgressBar(int durations, Status status){
    print('create lpb');
    this.status = status;
    print('Status ${status}');
    int multiply = (1000 / times).floor();
    this.durations = durations * multiply;
    this.decrement = 1 / times;
  }
  @override
  _LinearProgressBarState createState() => _LinearProgressBarState();

}

class _LinearProgressBarState extends State<LinearProgressBar> {
  double value = 1;
  bool get isTimeout => (value <= 0);
  @override
  Widget build(BuildContext context) {
    print('build linear progress');
    if(widget.isNew){
      setState(() {
        updateProgress(context);
        widget.isNew = false;
      });
    }
    return LinearProgressIndicator(
      value: value,
    );
  }

  void updateProgress(context) {
    print('call update');
    Timer.periodic(Duration(milliseconds: widget.durations), (timer) async {
      if(widget.status == Status.onSubmit){
        timer.cancel();
      }else if (widget.status == Status.onLoad){
        setState((){
          if (isTimeout) {
            timer.cancel();
            showDialog(context: context,
              builder: (context) => AlertDialog(
                title: Text('Timeout !!!'),
              ),
            );
            print('is timeout');
          }else{
            value -= widget.decrement;
          }
      });
    }
    });
  }
}
