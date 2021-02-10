class ApiConfigure {
  static final ApiConfigure _instance = ApiConfigure._internal();
  // static final host = 'http://127.0.0.1:8000/';
  static final host = 'http://192.168.43.164:8000/';
  // static final host = 'http://192.168.1.37:8000/';
  static final questionApi = host + 'v1/api/question/';
  static final usersApi = host + 'v1/api/users/';
  static final historyApi = host + 'v1/api/history/';
  static final responseKey = 'response';
  static final questionApiLimit = questionApi + '?limit=1';
  static final questionKey = 'question';
  static final choiceKey = 'choice';

  factory ApiConfigure() {
    print('ApiConfigure: singleton created');
    return _instance;
  }

  ApiConfigure._internal() {
    print('ApiConfigure: singleton created');
  }
}
