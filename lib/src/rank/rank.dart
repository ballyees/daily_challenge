import 'package:daily_challenge/src/api_provider.dart';
import 'package:daily_challenge/src/global_configure.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            String userId = PreferenceUtils.getString(GlobalConfigure.userIdPrefKey);
            String username = PreferenceUtils.getString(GlobalConfigure.usernamePrefKey);
            int rank = -1;
            data.forEach((element) {
              String key = element.keys.first;
              print('key: ${element.keys.first}');
              if(key == userId || key == username){
                rank = element[key][1];
              }
            });
            // data = [...data, ...List.generate(5, (index) => {(index+2).toString(): [10-index, 10-index]})];
            String rank_str = (rank != -1?rank.toString():"undefined");
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(_paddingHorizontal),
              child: Container(
                child: Column(
                  children: [
                    Image(image: AssetImage('assets/Icon/Crown.png'), width: _textHeaderSize * 2, height: _textHeaderSize * 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ListViewBuilder(context, data, rank, _paddingVertical),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text('RANK : $rank_str'),
                        ),
                      ],
                    )
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
  Widget _ListViewBuilder(context, data, rank, paddingVertical){
    Color bgColor = Color.fromRGBO(255, 0, 0, 0.2);
    TextStyle textStyle = TextStyle(color: Colors.black);
    return Expanded(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Map item = data[index];
          String key = item.keys.first;
          if(index == GlobalConfigure.maxRankingShow){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0*((index < 2)?index:2)),
              child: Column(
                children: [
                  ...List.generate(3, (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: Color.fromRGBO(255, 255, 255, 0.2), size: 10,)
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: Chip(
                          backgroundColor: bgColor,
                          labelStyle: textStyle,
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (key.length > 20)?Text(key.substring(0, 20)):Text(key),
                              Text(item[key][0].toString())
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0*((index < 2)?index:2)),
            child: Chip(
              backgroundColor: bgColor,
              labelStyle: textStyle,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (key.length > 20)?Text(key.substring(0, 20)):Text(key),
                  Text(item[key][0].toString())
                ],
              ),
            ),
          );
        },),
    );
  }
}
