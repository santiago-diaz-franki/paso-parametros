import 'package:flutter/material.dart';
import 'package:hola_mundo/models/chiste.dart';
import 'package:hola_mundo/services/chistes_service.dart';

class ChisteDetailView extends StatefulWidget {
  final String id;

  const ChisteDetailView({super.key, required this.id});

  @override
  State<ChisteDetailView> createState() => _ChisteDetailViewState();
}

class _ChisteDetailViewState extends State<ChisteDetailView> {
  final ChistesService _chistesService = ChistesService();
  late Future<Chiste> _futureChiste;

  @override
  void initState() {
    super.initState();
    _futureChiste = _chistesService.getChisteById(widget.id); // Obtener el chiste por ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de ${widget.id.toUpperCase()}')),
      body: FutureBuilder<Chiste>(
        future: _futureChiste,
        builder: (context, snapshot) {
          // Verifica el estado de la conexión
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final chiste = snapshot.data!; // Obtener los datos del chiste
            return Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        chiste.icon,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        chiste.id.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        chiste.value,  // Muestra el texto del chiste
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        chiste.url,  // Muestra la URL del chiste
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text('No se encontró el chiste.'));
        },
      ),
    );
  }
}
