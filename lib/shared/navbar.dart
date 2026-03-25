import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,

      // 🎨 Estilos
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.orange.withOpacity(0.6),
      showUnselectedLabels: true,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart), // dashboard
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build), // genérico
          label: 'Opción 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory), // genérico
          label: 'Opción 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings), // genérico
          label: 'Opción 3',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person), // usuario
          label: 'Usuario',
        ),
      ],
    );
  }
}