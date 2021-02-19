import 'package:daily_challenge/src/api_provider.dart';
import 'package:flutter/material.dart';

class HistoryQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiProvider.getHistory(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print('data: ${snapshot.data}');
            return Scaffold();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
