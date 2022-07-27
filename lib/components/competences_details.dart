import 'package:flutter/material.dart';

class CompetenceDetails extends StatelessWidget {
  final String title;
  final String text;
  final List<String> tags;

  const CompetenceDetails(
      {Key? key, required this.title, required this.text, required this.tags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline2,
          ),
          Expanded(
              child: Wrap(
            children: [],
          ))
        ],
      ),
    );
  }
}
