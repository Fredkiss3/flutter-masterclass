import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/pages/quizz.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _themeController = TextEditingController();
  final _questionController = TextEditingController();
  final _reponseController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _themeController.dispose();
    _questionController.dispose();
    _reponseController.dispose();
    super.dispose();
  }

  final baseUrl = 'https://daa7-80-15-154-187.ngrok.io';

  void createQuestion(BuildContext context) {
    setState(() {
      _isLoading = true;
    });

    http
        .post(Uri.parse('$baseUrl/question'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "id": QuizzAppScreen.nextID,
              "question": _questionController.text,
              "reponse": _reponseController.text,
              "theme": _themeController.text,
            }))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Question créée avec succès'),
          ),
        );
        Navigator.pop(context, true);
      }

      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      print('error from API: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer une question")),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _themeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Theme',
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Question',
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _reponseController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Réponse',
                  ),
                  maxLines: 8,
                  style: Theme.of(context).textTheme.bodyText1,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                createQuestion(context);
                              }
                            },
                      child: Text(_isLoading
                          ? "Envoi en cours..."
                          : 'Créer la question'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
