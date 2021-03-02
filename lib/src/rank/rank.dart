import 'package:daily_challenge/src/api_provider.dart';
import 'package:daily_challenge/src/global_configure.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RankPage extends StatelessWidget {
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
        future: ApiProvider.getRank(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List data = snapshot.data;
            data = [...data, ...List.generate(10, (index) => {index.toString(): [index, index+2]})];
            Map item;
            String key;
            String userId = PreferenceUtils.getString(GlobalConfigure.userIdPrefKey);
            String username = PreferenceUtils.getString(GlobalConfigure.usernamePrefKey);
            return SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Container(
                color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ranking', style: TextStyle(fontSize: _textHeaderSize),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            padding: EdgeInsets.symmetric(vertical: _paddingVertical),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              item = data[index];
                              key = item.keys.first;
                              print('$index : $item');
                              return Align(
                                alignment: Alignment.center,
                                  child: Text(key)
                              );
                          },),
                        ),
                      ],
                    ),
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
