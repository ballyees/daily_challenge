import 'package:daily_challenge/src/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class HistoryQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _appBarHeight = AppBar().preferredSize.height;
    double _textHeaderSize = _appBarHeight * 0.5;
    double _textBodySize = _textHeaderSize * 0.6;
    double _paddingHorizontal = 20;
    double _paddingVertical = 10;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ApiProvider.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data as Map;
            // print('data: ${snapshot.data}');
            data.keys.forEach((element) {
              print(data[element]);
            });
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'HISTORY',
                            style: TextStyle(fontSize: _textHeaderSize),
                          )
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Expanded(
                          child: FixedTimeline.tileBuilder(
                            // mainAxisSize: MainAxisSize.max,
                            builder: TimelineTileBuilder.fromStyle(
                              contentsAlign: ContentsAlign.basic,
                              contentsBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text('Timeline Event $index asdasdqweqwe123'),
                              ),
                              itemCount: 10,
                            ),
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget timeline(){
    return Timeline.tileBuilder(
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('Timeline Event $index'),
        ),
        itemCount: 10,
      ),
    );
  }
}
