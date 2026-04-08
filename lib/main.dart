import 'package:flutter/material.dart';
import 'pages/maquinaria_page.dart';
import 'pedidos/pedidos.dart'; // <--- AGREGA ESTA LÍNEA

void main() => runApp(const MakandApp());

class MakandApp extends StatelessWidget {
  const MakandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFFFF6B00)),
      initialRoute: '/maquinaria',
      routes: {
        '/inicio': (context) => const Scaffold(body: Center(child: Text('Pantalla Inicio'))),
        '/pedidos': (context) => const PedidosPage(), // <--- CAMBIA ESTO
        '/maquinaria': (context) => const MaquinariaPage(),
        '/perfil': (context) => const Scaffold(body: Center(child: Text('Pantalla Perfil'))),
      },
    );
  }
}