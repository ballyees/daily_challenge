class AnswerQuestionProvider {
  static final AnswerQuestionProvider _instance = AnswerQuestionProvider._internal();

  factory AnswerQuestionProvider() {
    print('AnswerQuestionProvider: singleton created');
    return _instance;
  }

  AnswerQuestionProvider._internal() {
    print('AnswerQuestionProvider: singleton created');
  }
}
