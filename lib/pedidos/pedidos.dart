import 'package:flutter/material.dart';
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar por cliente o ID...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

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
                            selectedColor:
                                const Color.fromARGB(255, 255, 115, 0),
                            labelStyle: TextStyle(
                              color:
                                  isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView(
                      children: [
                        PedidoCard(
                          id: "PED-2024-0156",
                          cliente: "Constructora López",
                          equipo: "Excavadora Hidráulica",
                          fecha: "Hoy, 10:30 AM",
                          estado: "En Progreso",
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) =>
                                  const PedidoDetalleModal(),
                            );
                          },
                        ),
                        const PedidoCard(
                          id: "PED-2024-0155",
                          cliente: "Inmobiliaria Norte",
                          equipo: "Retroexcavadora",
                          fecha: "Hoy, 09:15 AM",
                          estado: "Completado",
                        ),
                        const PedidoCard(
                          id: "PED-2024-0154",
                          cliente: "Obras Civiles S.A.",
                          equipo: "Montacargas 3T",
                          fecha: "Ayer, 4:45 PM",
                          estado: "En Progreso",
                        ),
                        const PedidoCard(
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

      bottomNavigationBar: CustomNavbar(
        currentIndex: 2,
        onTap: (index) {},
      ),
    );
  }
}

// 🔥 CARD
class PedidoCard extends StatelessWidget {
  final String id;
  final String cliente;
  final String equipo;
  final String fecha;
  final String estado;
  final VoidCallback? onTap;

  const PedidoCard({
    super.key,
    required this.id,
    required this.cliente,
    required this.equipo,
    required this.fecha,
    required this.estado,
    this.onTap,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(id,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            Text(cliente,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                const Icon(Icons.access_time,
                    size: 14, color: Colors.black54),
                const SizedBox(width: 4),
                Text(fecha, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 MODAL
class PedidoDetalleModal extends StatefulWidget {
  const PedidoDetalleModal({super.key});

  @override
  State<PedidoDetalleModal> createState() => _PedidoDetalleModalState();
}

class _PedidoDetalleModalState extends State<PedidoDetalleModal> {
  String estadoSeleccionado = "En proceso";

  final List<String> estados = ["En proceso", "Cerrado", "Cancelado"];

  final List<Map<String, dynamic>> maquinaria = [
    {
      "nombre": "Excavadora Hidráulica",
      "cantidad": 2,
      "precio": 500000,
      "peso": "20T"
    },
    {
      "nombre": "Retroexcavadora",
      "cantidad": 1,
      "precio": 300000,
      "peso": "15T"
    },
  ];

  void confirmarCambioEstado(String nuevoEstado) {
    if (nuevoEstado == estadoSeleccionado) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmación"),
        content: const Text(
            "¿Estás seguro que quieres cambiar el estado del pedido?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 115, 0),
            ),
            onPressed: () {
              setState(() {
                estadoSeleccionado = nuevoEstado;
              });
              Navigator.pop(context);
            },
            child: const Text("Cambiar"),
          ),
        ],
      ),
    );
  }

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
              // 🔥 HEADER CON X
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Detalle del Pedido",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _info("ID Pedido", "PED-2024-0156"),
              _info("Fecha", "Hoy, 10:30 AM"),
              _info("Proyecto", "Proyecto Torre Norte"),

              const SizedBox(height: 10),
              const Text("Estado del pedido"),

              DropdownButtonFormField(
                value: estadoSeleccionado,
                items: estados
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  confirmarCambioEstado(value!);
                },
              ),

              _info("Usuario", "Juan Pérez"),
              _info("Descuento", "\$50,000"),

              const SizedBox(height: 20),

              const Text("Maquinaria",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              ...maquinaria.map((m) => _maquinaItem(m)).toList(),
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

  Widget _maquinaItem(Map<String, dynamic> m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(m["nombre"],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Cantidad: ${m["cantidad"]}"),
          Text("Precio: \$${m["precio"]}"),
          Text("Peso: ${m["peso"]}"),
        ],
      ),
    );
  }
}