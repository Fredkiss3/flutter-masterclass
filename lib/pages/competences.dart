import 'package:flutter/material.dart';
import 'package:my_app/components/competence_card.dart';

class CompetenceScreen extends StatefulWidget {
  const CompetenceScreen({Key? key}) : super(key: key);

  @override
  State<CompetenceScreen> createState() => _CompetenceScreenState();
}

class _CompetenceScreenState extends State<CompetenceScreen> {
  int _selectedCompetence = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compétences'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: ListView(children: [
          Text(
            'En quoi je peux vous aider ?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 20,
          ),
          CompetenceCard(
            icon: Icons.desktop_mac,
            title: 'Frontend',
            color: Theme.of(context).colorScheme.primary,
            selected: _selectedCompetence == 0,
            onTap: () {
              setState(() {
                _selectedCompetence = 0;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CompetenceCard(
            icon: Icons.desktop_mac,
            title: 'Backend',
            color: Theme.of(context).colorScheme.tertiary,
            selected: _selectedCompetence == 1,
            onTap: () {
              setState(() {
                _selectedCompetence = 1;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CompetenceCard(
            icon: Icons.desktop_mac,
            title: 'Intégration HTML',
            color: Theme.of(context).colorScheme.secondary,
            selected: _selectedCompetence == 2,
            onTap: () {
              setState(() {
                _selectedCompetence = 2;
              });
            },
          ),
        ]),
      ),
    );
  }
}
