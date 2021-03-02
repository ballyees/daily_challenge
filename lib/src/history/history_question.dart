import 'package:daily_challenge/src/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoryQuestionPage extends StatefulWidget {
  @override
  _HistoryQuestionPageState createState() => _HistoryQuestionPageState();
}

class _HistoryQuestionPageState extends State<HistoryQuestionPage> {
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
            List keys = data.keys.toList();
            return SingleChildScrollView(
              physics: ScrollPhysics(),
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
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: keys.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TimelineTile(
                            isFirst: index == 0,
                            isLast: index+1 == keys.length,
                            alignment: TimelineAlign.start,
                            indicatorStyle: IndicatorStyle(
                              color: Colors.amber,
                            ),
                            endChild: GestureDetector(
                              onTap: () {
                                print('1 Tap');
                              },
                              child: Container(
                                // color: Colors.lightGreenAccent,
                                constraints: const BoxConstraints(
                                  minHeight: 50,
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ExpansionTile(
                                        title: Text(
                                          keys.elementAt(index).toString(),
                                          style: TextStyle(
                                              fontSize: _textBodySize),
                                        ),
                                        expandedAlignment: Alignment.centerLeft,
                                        children: [
                                          ...List.generate(
                                            data[keys.elementAt(index)].length,
                                            (innerIndex) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2),
                                              child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Tooltip(
                                                            message: data[keys.elementAt(index)][innerIndex]['create_date'].toString().substring(11),
                                                            child: Chip(
                                                              label: Text(data[keys.elementAt(index)][innerIndex]['create_date']
                                                                  .toString().substring(11, 19)),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Expanded(
                                                            child: Text(data[keys.elementAt(index)][innerIndex]['question']
                                                                .toString()),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                            )),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
