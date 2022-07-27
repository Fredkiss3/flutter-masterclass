import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class CompetenceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const CompetenceCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.color,
      required this.onTap,
      this.selected = false})
      : super(key: key);

  @override
  State<CompetenceCard> createState() => _CompetenceCardState();
}

class _CompetenceCardState extends State<CompetenceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.selected
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.black12,
                width: 2),
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ),
    );
  }
}
