import 'dart:convert';

class Pokemon {
  final String name;
  final String pngURL;
  final String svgURL;
  final int id;

  Pokemon(
      {required this.id,
      required this.name,
      required this.svgURL,
      required this.pngURL});

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'],
      name: map['name'],
      svgURL:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${map['id']}.svg",
      pngURL:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${map['id']}.png",
    );
  }

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source));

  @override
  String toString() {
    return """Pokemon(id: $id, name: '$name', png: '$pngURL', svg: '$svgURL')""";
  }
}
