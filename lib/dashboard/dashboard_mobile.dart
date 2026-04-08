import 'package:flutter/material.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Makand"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Panel Principal",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            
            Container(
              
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard("Total Equipos", "156", context),
                  _buildCard("Pedidos Activos", "23", context),
                ],
            )
            ),

            Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard("Clientes Activos", "47", context),
                  _buildCard("Ingresos", "C\$ 245,680", context),
                ],
            )
            ),
            

            const SizedBox(height: 20),

            const Text(
              "Actividad Reciente",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _buildActivity("Nuevo pedido ORD-024"),
            _buildActivity("Pago recibido C\$ 15,000"),
            _buildActivity("Equipo devuelto"),
            _buildActivity("Cliente registrado"),

            const SizedBox(height: 40),

            const Text(
              "Estadísticas del Mes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _buildProgress("Equipos en Alquiler", 0.44),
            _buildProgress("Pagos Pendientes", 0.25),
            _buildProgress("Pedidos Completados", 0.80),
          ],
        ),
      ),
    );
  }


  // 🔥 CARD MODERNA
  Widget _buildCard(String title, String value, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      width: MediaQuery.of(context).size.width * 0.46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.build),
          Text(title),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 ACTIVIDAD
  Widget _buildActivity(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  // 🔥 PROGRESS
  Widget _buildProgress(String title, double value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.orange.shade100,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}