import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class TareaPesadaView extends StatefulWidget {
  const TareaPesadaView({super.key});

  @override
  State<TareaPesadaView> createState() => _TareaPesadaViewState();
}

class _TareaPesadaViewState extends State<TareaPesadaView> {
  String resultado = "Presiona el botón para ejecutar";

  //!Función que ejecuta la tarea pesada en un Isolate
  Future<void> isolateTask() async {
    final receivePort = ReceivePort(); // Buzón para recibir datos

    // Lanza un nuevo Isolate y le pasa el canal de comunicación principal
    await Isolate.spawn(_simulacionTareaPesada, receivePort.sendPort);

    // Espera a recibir el sendPort del nuevo isolate
    final sendPort = await receivePort.first as SendPort;

    // Crea un canal para recibir la respuesta
    final response = ReceivePort();

    // Envía un mensaje al isolate: datos + cómo responder (replyPort)
    sendPort.send(["Hola desde el hilo principal", response.sendPort]);

    // Espera la respuesta del isolate
    final result = await response.first as String;

    //*Verificamos si el widget sigue montado antes de actualizar la UI
    if (!mounted) return;

    // Mostrar el resultado en un SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    // O si prefieres actualizar la UI con setState (pero usaremos el SnackBar en lugar de un Text)
    setState(() {
      resultado = result;
    });
  }

  //!simulacionTareaPesada es una función que simula una tarea pesada en un Isolate
  static void _simulacionTareaPesada(SendPort sendPort) async {
    final port = ReceivePort(); // Buzón interno del isolate
    sendPort.send(port.sendPort); // Se lo enviamos al hilo principal
    // Espera a recibir mensajes
    await for (final message in port) {
      final data = message[0] as String; // Mensaje recibido
      final puertoReceptor = message[1] as SendPort; // Canal para responder

      int counter = 0;
      // Simula una tarea pesada (Suma de 1 a 2 millones) con un retardo artificial
      for (int i = 1; i <= 2000000; i++) {
        counter += i;

        // Agregamos un retardo para hacer la tarea más visible
        if (i % 50000 == 0) {
          await Future.delayed(const Duration(milliseconds: 1)); // Retardo artificial
        }
      }

      // Enviar el resultado al hilo principal
      puertoReceptor.send(
        "Tarea completada. Suma del 1 al 2 millones: $counter. -  Mensaje recibido: '$data'",
      );
      port.close(); // Cierra el puerto
      Isolate.exit(); // Finaliza el Isolate
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Demo de Isolate",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(resultado, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isolateTask,
                child: const Text("Ejecutar suma de 1 a 2 millones"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
