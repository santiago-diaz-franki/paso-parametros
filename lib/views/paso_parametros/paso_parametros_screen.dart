import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart'; // Importar go_router

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController controller =
      TextEditingController(); // Controlador de texto

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Dos pestañas
  }

  @override
  void dispose() {
    controller.dispose(); // Liberar el controlador de texto
    _tabController.dispose(); // Liberar el controlador de pestañas
    super.dispose();
  }

  /// Método goToDetalle que se utiliza para navegar
void goToDetalle(String metodo, String valor) {
  if (valor.isEmpty) return; // Si el valor está vacío, no hacemos nada

  switch (metodo) {
    case 'go':
      context.go('/detalle/$valor/$metodo');
      break;
    case 'push':
      context.push('/detalle/$valor/$metodo');
      break;
    case 'replace':
      context.replace('/detalle/$valor/$metodo');
      break;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'GridView'), Tab(text: 'Carrusel')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // GridView
          GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Número de columnas
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
  ),
  itemCount: 20, // Número de elementos
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        // Pasar el índice del ítem al siguiente screen
        goToDetalle('push', 'Item $index'); // Pasamos el texto "Item $index"
      },
      child: Container(
        color: Colors.blue[(index % 9 + 1) * 100],
        child: Center(child: Text('Item $index')),
      ),
    );
  },
),
          // Carrusel de imágenes
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
            items:
                [
                  'https://external-preview.redd.it/fgdaxmUcGe_TAatnSmZzD6LTqmTVKWwBFiyFWC1qUvU.jpg?width=1080&crop=smart&auto=webp&s=51f5105622c29748b9e737e76ad8bc7b92d3aabf',
                  'https://external-preview.redd.it/heres-like-100-more-environment-screenshots-in-4k-to-use-as-v0-OdiurmQhB7HNiEZLKdDxwcU_F3qizHXF0Qun8S1RejQ.jpg?auto=webp&s=5469e972b0297a27e7071e86d39ccd48472681bc',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWjeHL3WPuvsPTI9yjyCCwg2vHg1EnGQQOaA&s',
                ].map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(url, fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
