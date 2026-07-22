// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavbar({
    super.key, 
    required this.currentIndex, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          onTap(index); // Mantiene el estado visual
          // Lógica de navegación por rutas
          switch (index) {
            case 0: Navigator.pushReplacementNamed(context, '/inicio'); break;
            case 1: Navigator.pushReplacementNamed(context, '/proyectos'); break;
            case 2: Navigator.pushReplacementNamed(context, '/pedidos'); break;
            case 3: Navigator.pushReplacementNamed(context, '/maquinaria'); break;
            case 4: Navigator.pushReplacementNamed(context, '/perfil'); break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6B00),
        unselectedItemColor: const Color(0xFF94A3B8),
        showSelectedLabels: false, 
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 28), label: 'Inicio'),
          const BottomNavigationBarItem(icon: Icon(Icons.bookmark_added_sharp, size: 28), label: 'Proyectos'),
          const BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined, size: 26), label: 'Pedidos'),
          const BottomNavigationBarItem(icon: Icon(Icons.local_shipping, size: 28), label: 'Maquinaria'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 28), label: 'Perfil'),
        ],
      ),
    );
  }
}