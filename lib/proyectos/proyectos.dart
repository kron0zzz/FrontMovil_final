import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({super.key});

  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  // Definimos una sombra estándar para reutilizar en todas las cartas
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pagina de proyectos en desarrollo')
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}