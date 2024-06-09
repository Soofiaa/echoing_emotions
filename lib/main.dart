import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'pantalla_inicio_sesion.dart'; // Importa el widget de la pantalla de inicio de sesión
import 'pantalla_mi_perfil.dart'; // Importa el widget de la pantalla siguiente al inicio de sesión
import 'pantalla_estadisticas.dart'; // Importa el widget de estadísticas
import 'GEStion_estadísticas.dart'; // Importa la clase EmotionStatistics

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmotionStatistics()),
        FutureProvider<String>(
          create: (_) async {
            Directory documentsDir = await getApplicationDocumentsDirectory();
            return documentsDir.path;
          },
          initialData: '',
        ),
      ],
      child: MaterialApp(
        home: LoginScreen(), // Usa LoginScreen como la pantalla de inicio
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('es', 'ES'), // Spanish
        ],
        locale: const Locale('es'), // Set default locale to Spanish
        routes: {
          '/estadisticas': (context) => EstadisticasEmojis(),
        },
      ),
    );
  }
}
