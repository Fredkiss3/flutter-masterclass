import 'dart:convert';

class Question {
  final String theme;
  final int id;
  final String question;
  final String reponse;
  bool deleted = false;

  Question({
    required this.theme,
    required this.question,
    required this.reponse,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'question': question,
      'reponse': reponse,
      'id': id,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      theme: map['theme'],
      question: map['question'],
      reponse: map['reponse'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
