import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

/// !CicloVidaScreen
/// Nos permite entender cómo funciona el ciclo de vida
/// de un StatefulWidget en Flutter.

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => CicloVidaScreenState();
}

class CicloVidaScreenState extends State<CicloVidaScreen> {
  String texto = "texto inicial 🟢";

  /// Se ejecuta una vez cuando la pantalla es creada.
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("🟢 initState() -> La pantalla se ha inicializado");
    }
    // Este método solo se ejecuta una vez cuando el widget se inserta en la árbol de widgets.
  }

  /// !didChangeDependencies se ejecuta cada vez que las dependencias del widget cambian
  /// En general, este método se invoca después de `initState`, y luego cada vez que las dependencias
  /// del widget cambian, como si hay cambios en el `InheritedWidget` que este widget observa.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (kDebugMode) {
      print("🟡 didChangeDependencies() -> Tema actual");
    }
    // Este método se ejecuta cuando el widget se reconstruye debido a un cambio en las dependencias.
    // Es útil para obtener acceso a objetos como `InheritedWidget` y otros objetos que dependen de
    // las configuraciones del contexto.
  }

  /// Se ejecuta cada vez que el widget es reconstruido.
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("🔵 build() -> Construyendo la pantalla");
    }

    return BaseView(
      title: "Ciclo de Vida en Flutter",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: actualizarTexto,
              child: const Text("Actualizar Texto"),
            ),
          ],
        ),
      ),
    );
  }

  // Actualiza el texto y lo muestra en la pantalla
  void actualizarTexto() {
    setState(() {
      texto = "Texto actualizado 🟠";
      if (kDebugMode) {
        print("🟠 setState() -> Estado actualizado");
      }
    });
    // Este método se ejecuta cuando se llama a setState(), lo cual marca el widget como "sucio"
    // y solicita su reconstrucción (re-ejecución del build).
  }

  /// Se ejecuta cuando el widget es eliminado de la memoria.
  @override
  void dispose() {
    if (kDebugMode) {
      print("🔴 dispose() -> La pantalla se ha destruido");
    }
    super.dispose();
    // Este método se ejecuta cuando el widget es destruido de la memoria (por ejemplo, cuando
    // el widget es removido del árbol de widgets). Aquí puedes liberar recursos o hacer limpieza.
  }
}
