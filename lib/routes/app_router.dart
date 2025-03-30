import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/paso_parametros/detalle_screen.dart';
import 'package:hola_mundo/views/paso_parametros/paso_parametros_screen.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/settings_view.dart';
import 'package:hola_mundo/views/timer/timer_view.dart';
import 'package:hola_mundo/views/tarea_pesada/tarea_pesada_view.dart';
import 'package:hola_mundo/views/list_students/list_students_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // Ruta principal - Página de inicio
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(), // Usa HomeView
    ),
    // Ruta para la configuración
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(), // Usa SettingsView
    ),
    // Ruta para el perfil
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(), // Usa ProfileView
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detalle/:parametro/:metodoNavegacion',
      builder: (context, state) {
        final parametro = state.pathParameters['parametro']!;
        final metodoNavegacion = state.pathParameters['metodoNavegacion']!;
        return DetalleScreen(
          parametro: parametro,
          metodoNavegacion: metodoNavegacion,
        );
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    //!Ruta para el demo de Future
    GoRoute(
      path: '/list_students',
      name: 'list_students',
      builder: (context, state) => const ListStudentsView(),
    ),
    //!Ruta para el demo de Timer
    GoRoute(
      path: '/timer',
      name: 'timerView',
      builder: (context, state) => const TimerView(),
    ),

    //!Ruta para el demo de Isolate
    GoRoute(
      path: '/isolate', //*ruta para el demo de Isolate
      name: 'isolate', //*nombre de la ruta
      builder: (context, state) => const TareaPesadaView(),
    ),
  ],
);
