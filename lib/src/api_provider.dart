import 'dart:convert';

import 'package:daily_challenge/src/global_configure.dart';
import 'package:daily_challenge/src/preference_utils.dart';
import 'package:http/http.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  // static final host = 'http://127.0.0.1:8000/';
  static final host = 'http://192.168.1.37:8000/';
  static final questionApi = host + 'v1/api/question/';
  static final usersApi = host + 'v1/api/users/';
  static final historyApi = host + 'v1/api/history/';
  static final responseKey = 'response';
  static final responseGeneratedKeys = 'generated_keys';
  static final questionApiLimit = questionApi + '?limit=2';
  static final questionKey = 'question';
  static final choiceKey = 'choice';

  factory ApiProvider() {
    print('ApiProvider: singleton created');
    return _instance;
  }

  ApiProvider._internal() {
    print('ApiProvider: singleton created');
  }

  static Future<Response> getQuestion() async {
    // return await get(questionApi);
    return await get(questionApiLimit);
  }

  static Future<String> getUserId() async {
    return await PreferenceUtils.init().then((pref) async {
      String userId = pref.getString(GlobalConfigure.userIdPrefKey);
      if (userId == null){
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

  static Future<Map> getHistory() async {
    return await get(historyApi, headers: <String, String>{'userId': PreferenceUtils.getString(GlobalConfigure.userIdPrefKey)}).then((res){
      // print(jsonDecode(res.body)[responseKey]);
      return jsonDecode(res.body)[responseKey];
    });
  }

  static Future<bool> postHistory(String choice, String question) async {
    // final userId = PreferenceUtils.getString(GlobalConfigure.userIdPrefKey);
    return await post(historyApi, body: jsonEncode({'userId': PreferenceUtils.getString(GlobalConfigure.userIdPrefKey), 'choice': choice, 'questionId': question})).then((res){
      return res.statusCode < 400;
    });
  }
}
