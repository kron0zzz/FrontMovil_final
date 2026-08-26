import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/presentation/screens/dashboard_screen.dart';
import 'package:flutter_app/presentation/screens/machinery_screen.dart';
import 'package:flutter_app/presentation/screens/projects_screen.dart';
import 'package:flutter_app/presentation/screens/orders_screen.dart';
import 'package:flutter_app/presentation/screens/customers_screen.dart';

class MainScreen extends StatefulWidget {
  final String token;
  final Map<String, dynamic> user;
  final VoidCallback onLogout;

  const MainScreen({
    super.key,
    required this.token,
    required this.user,
    required this.onLogout,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      DashboardScreen(token: widget.token),
      MachineryScreen(token: widget.token),
      ProjectsScreen(token: widget.token),
      OrdersScreen(token: widget.token),
      CustomersScreen(token: widget.token),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.bolt, color: AppColors.card, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              'Makand',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: widget.onLogout,
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.precision_manufacturing_outlined),
            activeIcon: Icon(Icons.precision_manufacturing),
            label: 'Maquinaria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering_outlined),
            activeIcon: Icon(Icons.engineering),
            label: 'Proyectos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Clientes',
          ),
        ],
      ),
    );
  }
}
