import 'package:flutter/material.dart';
import 'pages/maquinaria_page.dart';
import 'pedidos/pedidos.dart'; 
import 'dashboard/dashboard.dart';
import 'perfil/perfil.dart';
import 'login/login.dart';
import 'proyectos/proyectos.dart';

void main() {
  runApp(const MakandApp());
}

class MakandApp extends StatelessWidget {
  const MakandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makand Movil',
      
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF6B00),
        brightness: Brightness.light,
      ),

      initialRoute: '/login',
      
      // Mapa de rutas de la aplicación
      routes: {
        '/login': (context) => const LoginPage(),
        '/inicio': (context) => const DashboardMobile(),
        '/maquinaria': (context) => const MaquinariaPage(),
        '/proyectos' : (context) => const ProyectosPage(),
        '/pedidos': (context) => const PedidosPage(),
        '/perfil': (context) => const PerfilPage(),
      },
    );
  }
}