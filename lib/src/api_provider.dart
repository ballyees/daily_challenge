import 'dart:convert';

import 'package:daily_challenge/src/global_configure.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  static final host = 'http://192.168.1.37:8000/';
  // static final host = 'http://192.168.43.164:8000/';
  static final questionApi = host + 'v1/api/question/';
  static final usersApi = host + 'v1/api/users/';
  static final historyApi = host + 'v1/api/history/';
  static final rankApi = usersApi + 'rank/?k=${GlobalConfigure.maxRankingShow}';
  static final responseKey = 'response';
  static final responseGeneratedKeys = 'generated_keys';
  static final questionApiLimit = questionApi + '?limit=5';
  static final questionKey = 'question';
  static final choiceKey = 'choice';

  factory ApiProvider() {
    print('ApiProvider: singleton created');
    return _instance;
  }

  ApiProvider._internal() {
    print('ApiProvider: singleton created');
  }

  ///online
  static Future<Response> getQuestion() async {
    // return await get(questionApi);
    return await get(questionApiLimit);
  }
  // ///offline-test
  // static Future<String> getQuestion() async {
  //   return await rootBundle.loadString("assets/question.json");
  // }

  static Future<String> getUserId() async {
    return await PreferenceUtils.init().then((pref) async {
      String userId = pref.getString(GlobalConfigure.userIdPrefKey);
      if (userId == null) {
        // /// offline-test
        // var functionDummy = <String>(dummy) async {
        //   return dummy;
        // };
        // return await functionDummy('dummy-userID').then((res){
        //     userId = res;
        //     pref.setString(GlobalConfigure.userIdPrefKey, userId);
        //     return userId;
        // });
        ///online
        return await post(usersApi, body: jsonEncode({'mode': 0})).then((res) {
          Map dataResponse = jsonDecode(res.body)[responseKey];
          userId = dataResponse[responseGeneratedKeys][0];
          pref.setString(GlobalConfigure.userIdPrefKey, userId);
          return userId;
        });
      }
      return userId;
    });
  }

  static Future<bool> registerUser(Map data) async {
      return await post(usersApi, body: jsonEncode({...data, 'mode': 1})).then((res) {
        Map dataResponse = jsonDecode(res.body)[responseKey];
        return Future.value(true);
      });
  }

  static Future<Map> getHistory() async {
    return await get(historyApi, headers: <String, String>{
      GlobalConfigure.userIdPrefKey: PreferenceUtils.getString(GlobalConfigure.userIdPrefKey)
    }).then((res) {
      // print(jsonDecode(res.body)[responseKey]);
      return jsonDecode(res.body)[responseKey];
    });
  }

  static Future<List> getRank() async {
    String username = PreferenceUtils.getString(GlobalConfigure.usernamePrefKey);
    Map headers = <String, String>{
      GlobalConfigure.userIdPrefKey: PreferenceUtils.getString(GlobalConfigure.userIdPrefKey)
    };
    if(username != ''){
      headers[GlobalConfigure.usernamePrefKey] = username;
    }
    return await get(rankApi, headers: headers).then((res) {
      return jsonDecode(res.body)[responseKey];
    });
  }

  static Future<bool> postHistory(String choice, String question) async {
    return await post(historyApi,
        body: jsonEncode({
          GlobalConfigure.userIdPrefKey: PreferenceUtils.getString(GlobalConfigure.userIdPrefKey),
          'choice': choice,
          'questionId': question
        })).then((res) {
      return res.statusCode < 400;
    });
  }
}
