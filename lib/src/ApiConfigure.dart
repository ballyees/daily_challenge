class ApiConfigure {
  static final ApiConfigure _instance = ApiConfigure._internal();
  static final questionApi = 'http://192.168.1.37:8000/v1/api/question/';
  static final usersApi = 'http://192.168.1.37:8000/v1/api/users/';
  static final historyApi = 'http://192.168.1.37:8000/v1/api/history/';
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
