class Chiste {
  final String icon; // El URL del icono
  final String id; // El ID del chiste
  final String url; // La URL para ver el chiste
  final String value; // El valor del chiste (el texto del chiste)

  // Constructor de la clase Chiste
  Chiste({
    required this.icon,
    required this.id,
    required this.url,
    required this.value,
  });

  // Método para convertir el JSON en una instancia de la clase Chiste
  factory Chiste.fromJson(Map<String, dynamic> json) {
    return Chiste(
      icon: json['icon_url'], // Cambiar de 'sprites' a 'icon_url'
      id: json['id'],
      url: json['url'],
      value: json['value'],
    );
  }
}
