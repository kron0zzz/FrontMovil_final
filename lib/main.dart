import 'package:flutter/material.dart';
import 'pages/maquinaria_page.dart';
import 'pedidos/pedidos.dart'; 
import 'dashboard/dashboard.dart';
import 'perfil/perfil.dart';
import 'login/login.dart';

void main() {
  // Punto de entrada principal de la aplicación Luna Llena
  runApp(const MakandApp());
}

class MakandApp extends StatelessWidget {
  const MakandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luna Llena App',
      
      // Configuración del tema base (Modo Claro por defecto)
      // Utilizamos colorSchemeSeed para mantener la identidad visual naranja
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF6B00),
        brightness: Brightness.light,
      ),

      // Definimos la pantalla de maquinaria como la inicial según tu flujo previo
      initialRoute: '/login',
      
      // Mapa de rutas de la aplicación
      routes: {
        '/login': (context) => const LoginPage(),
        '/inicio': (context) => const DashboardMobile(),
        '/maquinaria': (context) => const MaquinariaPage(),
        '/pedidos': (context) => const PedidosPage(),
        '/perfil': (context) => const PerfilPage(),
      },
    );
  }
}