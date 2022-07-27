import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/components/question_card.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/model/question.dart';
import 'package:http/http.dart' as http;

class QuizzAppScreen extends StatefulWidget {
  const QuizzAppScreen({Key? key}) : super(key: key);
  static int nextID = 1;

  @override
  State<QuizzAppScreen> createState() => _QuizzAppScreenState();
}

class _QuizzAppScreenState extends State<QuizzAppScreen> {
  Map<int, Question> questions = {};

  final baseUrl = 'https://daa7-80-15-154-187.ngrok.io';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() {
    setState(() {
      _isLoading = true;
    });
    http.get(Uri.parse('$baseUrl/question')).then((response) {
      if (response.statusCode == 200) {
        Map<int, Question> questionLoaded = {};
        print(jsonDecode(response.body));
        for (var map in jsonDecode(response.body)) {
          var q = Question.fromMap(map);
          questionLoaded[q.id] = q;
        }

        setState(() {
          questions = {...questionLoaded};
          QuizzAppScreen.nextID = questions.length;

          _isLoading = false;
        });
      }
    });
  }

  void deleteQuestion(int id) {
    setState(() {
      questions[id]!.deleted = true;
    });

    http.delete(Uri.parse('$baseUrl/question/$id')).then((response) {
      if (response.statusCode == 200) {
        loadQuestions();
      } else {
        setState(() {
          questions[id]!.deleted = false;
        });
      }
    });
  }

  Future<void> _showMyDialog(
      {required String question, required int id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Supprimer la question suivante ?',
            style: Theme.of(context).textTheme.headline2,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  question,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: dangerColor),
              child: const Text('Supprimer'),
              onPressed: () {
                deleteQuestion(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var questionList = [...questions.values.map((e) => e)];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: secondaryColor),
                onPressed: () async {
                  var result =
                      await Navigator.of(context).pushNamed('/create-question');
                  if (result != null) {
                    loadQuestions();
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Ajouter un nouveau'),
                  ],
                )),
          ),
          Expanded(
            child: questionList.isEmpty
                ? Center(
                    child: Text(
                      _isLoading
                          ? 'Chargement des questions...'
                          : 'Aucune question disponible',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: questions.length,
                    itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: QuestionCard(
                          question: questionList[index],
                          onDelete: _showMyDialog,
                        )))),
          ),
        ],
      ),
    );
  }
}
