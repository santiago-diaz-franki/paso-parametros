import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/chiste.dart';
import 'package:hola_mundo/services/chistes_service.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:hola_mundo/views/chiste/api_exceptions.dart';

class ChisteListView extends StatefulWidget {
  const ChisteListView({super.key});

  @override
  State<ChisteListView> createState() => _ChisteListViewState();
}

class _ChisteListViewState extends State<ChisteListView> {
  final ChistesService _chistesService = ChistesService();
  late Future<List<Chiste>> _futureChiste;

  @override
  void initState() {
    super.initState();
    _futureChiste = _chistesService.getChistes();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Lista de Chistes',
      body: FutureBuilder<List<Chiste>>(
        future: _futureChiste,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            String errorMessage = 'Ocurrió un error al obtener los chistes.';

            if (error is ApiException) {
              errorMessage = error.message;
            }

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureChiste = _chistesService.getChistes();
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final chistes = snapshot.data!;
            return ListView.builder(
              itemCount: chistes.length,
              itemBuilder: (context, index) {
                final chiste = chistes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.push('/chiste/${chiste.id}');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                chiste.icon,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chiste.id.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    chiste.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No hay chistes disponibles.'));
        },
      ),
    );
  }
}
