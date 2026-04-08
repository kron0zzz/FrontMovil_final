import 'package:flutter/material.dart';
// Importamos saliendo de la carpeta 'pedidos' para entrar a 'widgets'
import '../widgets/custom_navbar.dart'; 

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  String selectedFilter = "Todos";

  final List<String> filters = [
    "Todos",
    "En Progreso",
    "Completado",
    "Pendiente"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // 🔥 HEADER NARANJA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 115, 0),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pedidos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Gestiona todos tus pedidos",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // 🔥 CONTENIDO PRINCIPAL
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 🔍 BUSCADOR
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar por cliente o ID...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔥 FILTROS (ChoiceChips)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filters.map((filter) {
                        final isSelected = filter == selectedFilter;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                selectedFilter = filter;
                              });
                            },
                            selectedColor: const Color.fromARGB(255, 255, 115, 0),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔥 LISTA DE TARJETAS DE PEDIDO
                  Expanded(
                    child: ListView(
                      children: const [
                        PedidoCard(
                          id: "PED-2024-0156",
                          cliente: "Constructora López",
                          equipo: "Excavadora Hidráulica",
                          fecha: "Hoy, 10:30 AM",
                          estado: "En Progreso",
                        ),
                        PedidoCard(
                          id: "PED-2024-0155",
                          cliente: "Inmobiliaria Norte",
                          equipo: "Retroexcavadora",
                          fecha: "Hoy, 09:15 AM",
                          estado: "Completado",
                        ),
                        PedidoCard(
                          id: "PED-2024-0154",
                          cliente: "Obras Civiles S.A.",
                          equipo: "Montacargas 3T",
                          fecha: "Ayer, 4:45 PM",
                          estado: "En Progreso",
                        ),
                        PedidoCard(
                          id: "PED-2024-0153",
                          cliente: "Constructora del Valle",
                          equipo: "Grúa Torre",
                          fecha: "Ayer, 2:20 PM",
                          estado: "Pendiente",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🚀 BARRA DE NAVEGACIÓN
      bottomNavigationBar: CustomNavbar(
        currentIndex: 1, // Indica que estamos en la pestaña 1 (Pedidos)
        onTap: (index) {
          // La lógica de redirección ya está configurada en el switch de tu CustomNavbar
        },
      ),
    );
  }
}

// 🔥 WIDGET DE LA TARJETA (Se mantiene en el mismo archivo para evitar errores de import)
class PedidoCard extends StatelessWidget {
  final String id;
  final String cliente;
  final String equipo;
  final String fecha;
  final String estado;

  const PedidoCard({
    super.key,
    required this.id,
    required this.cliente,
    required this.equipo,
    required this.fecha,
    required this.estado,
  });

  Color getEstadoColor() {
    switch (estado) {
      case "Completado":
        return Colors.green;
      case "Pendiente":
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getEstadoColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  estado,
                  style: TextStyle(
                    color: getEstadoColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            cliente,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.build, size: 14, color: Colors.black54),
              const SizedBox(width: 4),
              Text(equipo, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Colors.black54),
              const SizedBox(width: 4),
              Text(fecha, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}