import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer _timer;
  int _contador = 0;
  int _indiceSeleccionado = 0;
  bool _isPausado = false; // Indica si el temporizador está pausado
  bool _isIniciado = false; // Indica si el temporizador está iniciado

  @override
  void initState() {
    super.initState();
    // No iniciamos el temporizador aquí, ya que queremos que el usuario lo inicie
  }

  //! Método para iniciar el temporizador
  void _iniciarTemporizador() {
    if (!_isIniciado) {
      // Si el temporizador no está iniciado, comenzamos el temporizador
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _contador++;
        });
      });
      setState(() {
        _isIniciado = true; // Marcamos el temporizador como iniciado
        _isPausado = false; // Aseguramos que no esté pausado
      });
    } else if (_isPausado) {
      // Si el temporizador está pausado, reanudamos el temporizador
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _contador++;
        });
      });
      setState(() {
        _isPausado = false; // Lo reanudamos
      });
    }
  }

  //! Método para pausar el temporizador
  void _pausarTemporizador() {
    _timer.cancel();
    setState(() {
      _isPausado = true; // Marcamos el temporizador como pausado
    });
  }

  //! Método para reiniciar el contador
  void _reiniciarContador() {
    _timer.cancel();
    setState(() {
      _contador = 0; // Reinicia el contador
      _isPausado = false; // Restablece el estado de pausa
      _isIniciado = false; // Restablece el estado de iniciado
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //! Método para cambiar de sección
  void _itemSeleccionado(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      Center(
        child: Text(
          'Segundos: $_contador',
          style: const TextStyle(fontSize: 28),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Este ejemplo usa Timer.periodic para aumentar el contador '
          'automáticamente cada segundo. ',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ];

    return BaseView(
      title: 'Timer - TabBar ',
      body: Column(
        children: [
          Expanded(child: paginas[_indiceSeleccionado]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: !_isPausado && _isIniciado ? null : _iniciarTemporizador, // Solo habilita si no está pausado e iniciado
                child: const Text("Iniciar"),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isPausado || !_isIniciado ? null : _pausarTemporizador, // Solo habilita si está en marcha
                child: const Text("Pausar"),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _reiniciarContador, // Siempre habilitado
                child: const Text("Reiniciar"),
              ),
            ],
          ),
          BottomNavigationBar(
            currentIndex: _indiceSeleccionado,
            onTap: _itemSeleccionado,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Contador',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: 'Descripción',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
