import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/model/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final void Function({required int id, required String question}) onDelete;

  const QuestionCard({Key? key, required this.question, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: question.deleted ? 0.5 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.theme,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Q: ${question.question}',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'R: ${question.reponse}',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: dangerColor),
                    onPressed: question.deleted
                        ? null
                        : () {
                            onDelete(
                                question: question.question, id: question.id);
                          },
                    child: Text(question.deleted
                        ? "Suppression en cours..."
                        : 'Supprimer')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
