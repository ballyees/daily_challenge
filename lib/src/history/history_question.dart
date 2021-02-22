import 'package:daily_challenge/src/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            print('data: ${snapshot.data}');
            List keys = data.keys.toList();
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Expanded(
                            //   child: ExpansionTile(title: new Text("Numbers"),
                            //     children: <Widget>[
                            //       new Text("Number: 1"),
                            //       new Text("Number: 2"),
                            //       new Text("Number: 3"),
                            //       new Text("Number: 4"),
                            //       new Text("Number: 5")
                            //     ],
                            //   ),
                            // ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: keys.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => TimelineTile(
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
                                                keys
                                                    .elementAt(index)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: _textBodySize),
                                              ),
                                              expandedAlignment:
                                                  Alignment.centerLeft,
                                              children: <Widget>[
                                                ListView.builder(
                                                  itemCount: data[
                                                          keys.elementAt(index)]
                                                      .length,
                                                  itemBuilder:
                                                      (context, innerIndex) =>
                                                          Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(data[keys.elementAt(index)][innerIndex]['create_date'].toString())
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
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
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
