/// Modelo para representar un Pokemon con su nombre, imagen y tipos
class Pokemon {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  // Constructor de la clase Pokemon con los atributos requeridos
  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.types,
  });

  // MEtodo para convertir una instancia de Pokemon a un JSON
  //factory porque es un método que retorna una nueva instancia de la clase
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'],
      types: List<String>.from(json['types'].map((t) => t['type']['name'])),
    );
  }
}
