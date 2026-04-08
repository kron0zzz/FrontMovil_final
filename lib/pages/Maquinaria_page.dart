import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class MaquinariaPage extends StatefulWidget {
  const MaquinariaPage({super.key});

  @override
  State<MaquinariaPage> createState() => _MaquinariaPageState();
}

class _MaquinariaPageState extends State<MaquinariaPage> {
  final int _selectedIndex = 2; // Índice fijo para esta página

  final List<Map<String, dynamic>> _todosLosEquipos = [
    {"id": "EQ-001", "nombre": "Excavadora Hidráulica", "modelo": "CAT 320D", "estado": "Disponible", "color": Colors.green},
    {"id": "EQ-002", "nombre": "Retroexcavadora", "modelo": "JCB 3CX", "estado": "Alquilado", "color": Colors.orange},
    {"id": "EQ-003", "nombre": "Mezcladora de Concreto", "modelo": "Concrete 12p³", "estado": "Mantenimiento", "color": Colors.red},
    {"id": "EQ-004", "nombre": "Vibrocompactador", "modelo": "Dynapac CA250", "estado": "Disponible", "color": Colors.green},
  ];

  List<Map<String, dynamic>> _equiposFiltrados = [];

  @override
  void initState() {
    super.initState();
    _equiposFiltrados = _todosLosEquipos;
  }

  void _filtrarEquipos(String query) {
    setState(() {
      _equiposFiltrados = _todosLosEquipos
          .where((e) => e['nombre'].toLowerCase().contains(query.toLowerCase()) || 
                        e['id'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Header Naranja Limpio
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
            decoration: const BoxDecoration(
              color: Color(0xFFFF6B00),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Maquinaria', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                Text('Catálogo de equipos disponibles', style: TextStyle(color: Colors.white70, fontSize: 15)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Buscador Funcional
                  _buildSearchField(),
                  const SizedBox(height: 25),
                  
                  // Filtros Estáticos (Diseño)
                  const Text('Categoría', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _buildStaticFilters(['Todos', 'Motorizado', 'No Motorizado']),
                  
                  const SizedBox(height: 25),

                  // Lista Dinámica
                  ..._equiposFiltrados.map((item) => _buildCard(item)).toList(),
                  if (_equiposFiltrados.isEmpty) const Center(child: Text("No hay resultados")),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) {}, // La navegación se maneja dentro del widget
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15)],
      ),
      child: TextField(
        onChanged: _filtrarEquipos,
        decoration: const InputDecoration(
          hintText: 'Buscar equipos...',
          prefixIcon: Icon(Icons.search, color: Color(0xFFFF6B00)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildStaticFilters(List<String> labels) {
    return Row(
      children: labels.map((l) => Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: l == 'Todos' ? const Color(0xFFFF6B00) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(l, style: TextStyle(color: l == 'Todos' ? Colors.white : Colors.grey)),
      )).toList(),
    );
  }

  Widget _buildCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.construction_rounded, color: Color(0xFFFF6B00), size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['id'], style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                Text(item['nombre'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Text(item['modelo'], style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: item['color'].withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Text('● ${item['estado']}', style: TextStyle(color: item['color'], fontSize: 11, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}