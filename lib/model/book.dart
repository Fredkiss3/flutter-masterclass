class Book {
  final String titre;
  final String auteur;
  final int prix;

  const Book({required this.titre, required this.auteur, required this.prix});

  String vue() {
    return "Book(titre: '$titre', auteur: '$auteur', prix: $prix)";
  }
}

void main(List<String> args) {
  var b = const Book(titre: 'Harry Potter', auteur: 'JK Rowlings', prix: 5000);
  print(b.vue());
}
