import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class ListStudentsView extends StatefulWidget {
  const ListStudentsView({super.key});

  @override
  State<ListStudentsView> createState() => _ListStudentsViewState();
}

class _ListStudentsViewState extends State<ListStudentsView> {
  List<String> _nombres = []; // Lista para almacenar los nombres de los estudiantes

  @override
  void initState() {
    super.initState();
    obtenerDatos(); // Cargar los datos al iniciar
  }

  // Simula la carga de los datos con un retraso de 5 segundos
  Future<List<String>> cargarNombres() async {
    // Usamos Future.delayed para simular un retraso de 5 segundos
    await Future.delayed(const Duration(seconds: 5)); // Simula un retraso de 5 segundos
    return [
      'Franki',
      'Alambrito',
      'ElZapatito',
      'Batman',
      'Superman',
      'Jebus'
    ];
  }

  // Obtiene los datos y los asigna a la lista _nombres
  Future<void> obtenerDatos() async {
    final datos = await cargarNombres();
    if (!mounted) return;
    setState(() {
      _nombres = datos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Futures - ListView',
      body: _nombres.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Muestra el indicador mientras se cargan los datos
          : ListView.builder(
              itemCount: _nombres.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromRGBO(161, 0, 161, 0.4),
                  child: ListTile(
                    title: Text(
                      _nombres[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
