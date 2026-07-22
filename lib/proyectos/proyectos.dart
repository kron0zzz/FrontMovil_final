import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({super.key});

  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 115, 0),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const CrearProyectoModal(),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
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
                  "Proyectos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Gestiona todos tus proyectos",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar proyecto...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView(
                      children: [
                        ProyectoCard(
                          id: "PROY-001",
                          nombre: "Torre Norte",
                          cliente: "Constructora López",
                          ciudad: "Medellín",
                          estado: "Activo",
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) =>
                                  const ProyectoDetalleModal(),
                            );
                          },
                        ),
                        const ProyectoCard(
                          id: "PROY-002",
                          nombre: "Edificio Central",
                          cliente: "Inmobiliaria Norte",
                          ciudad: "Bogotá",
                          estado: "Activo",
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

      bottomNavigationBar: CustomNavbar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}

// 🔥 CARD
class ProyectoCard extends StatelessWidget {
  final String id;
  final String nombre;
  final String cliente;
  final String ciudad;
  final String estado;
  final VoidCallback? onTap;

  const ProyectoCard({
    super.key,
    required this.id,
    required this.nombre,
    required this.cliente,
    required this.ciudad,
    required this.estado,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Text(id, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 6),
            Text(nombre,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(cliente),
            const SizedBox(height: 4),
            Text(ciudad),
          ],
        ),
      ),
    );
  }
}

// 🔥 MODAL DETALLE
class ProyectoDetalleModal extends StatelessWidget {
  const ProyectoDetalleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Detalle del Proyecto",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _info("ID", "PROY-001"),
              _info("Estado", "Activo"),
              _info("Cliente", "Constructora López"),
              _info("Nombre", "Torre Norte"),
              _info("Dirección", "Calle 123"),
              _info("Celular", "3001234567"),
              _info("Ciudad", "Medellín"),
            ],
          ),
        );
      },
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 🔥 MODAL CREAR (AQUÍ ESTÁ LA X NUEVA)
class CrearProyectoModal extends StatefulWidget {
  const CrearProyectoModal({super.key});

  @override
  State<CrearProyectoModal> createState() => _CrearProyectoModalState();
}

class _CrearProyectoModalState extends State<CrearProyectoModal> {
  String? cliente;
  String? ciudad;

  final clientes = ["Cliente A", "Cliente B", "Cliente C"];
  final ciudades = ["Medellín", "Bogotá", "Cali", "Barranquilla"];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            children: [
              // 🔥 HEADER CON X
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nuevo Proyecto",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                hint: const Text("Cliente"),
                value: cliente,
                items: clientes
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => cliente = value),
              ),

              const SizedBox(height: 12),

              const TextField(decoration: InputDecoration(labelText: "Nombre")),

              const SizedBox(height: 12),

              const TextField(decoration: InputDecoration(labelText: "Dirección")),

              const SizedBox(height: 12),

              const TextField(decoration: InputDecoration(labelText: "Celular")),

              const SizedBox(height: 12),

              DropdownButtonFormField(
                hint: const Text("Ciudad"),
                value: ciudad,
                items: ciudades
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => ciudad = value),
              ),
            ],
          ),
        );
      },
    );
  }
}