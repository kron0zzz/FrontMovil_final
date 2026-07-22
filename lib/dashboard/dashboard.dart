import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class DashboardMobile extends StatefulWidget {
  const DashboardMobile({super.key});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  // Definimos una sombra estándar para reutilizar en todas las cartas
  final List<BoxShadow> _cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟠 HEADER NARANJA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFFF6B00),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Inicio',
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Panel de Administrador',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 25),
                  
                  // GRID DE CARTAS SUPERIORES
                  Row(
                    children: [
                      _buildSummaryCard('Pedidos Activos', '24', Icons.inventory_2_outlined, const Color(0xFFFFE0D3), const Color(0xFFFF6B00)),
                      const SizedBox(width: 12),
                      _buildSummaryCard('Ingresos del Mes', '\$48,500', Icons.attach_money_rounded, const Color(0xFFD1FAE5), const Color(0xFF10B981)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildSummaryCard('Equipos en Uso', '87', Icons.local_shipping_outlined, const Color(0xFFFFE0D3), const Color(0xFFFF6B00)),
                      const SizedBox(width: 12),
                      _buildSummaryCard('Clientes Activos', '156', Icons.people_outline_rounded, const Color(0xFFD1FAE5), const Color(0xFF10B981)),
                    ],
                  ),
                ],
              ),
            ),

            // 🔔 NOTIFICACIONES
            _buildSectionTitle('Notificaciones Importantes'),
            _buildNotificationCard('Mantenimiento Programado', 'Excavadora CAT 320D requiere mantenimiento', 'Mañana', Icons.error_outline_rounded, Colors.orange),
            _buildNotificationCard('Revisión Pendiente', 'Retroexcavadora JCB 3CX - Revisión de 500 horas', 'En 3 días', Icons.error_outline_rounded, Colors.orange),

            // 💰 PAGOS PENDIENTES
            _buildSectionTitle('Pagos Pendientes'),
            _buildPaymentCard('Constructora San José', 'Vence: 15 Abr', '\$12,500'),
            _buildPaymentCard('Inversiones del Valle', 'Vence: 18 Abr', '\$8,900'),

            // 📊 ESTADÍSTICAS DEL MES
            _buildSectionTitle('Estadísticas del Mes'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildStatCard('Ingresos Totales', '\$124,500', '+12.5%', Icons.attach_money, const Color(0xFFD1FAE5), const Color(0xFF10B981)),
                      const SizedBox(width: 12),
                      _buildStatCard('Nuevos Pedidos', '38', '+8.2%', Icons.inventory_2_outlined, const Color(0xFFFFE0D3), const Color(0xFFFF6B00)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatCard('Equipos Alquilados', '87/120', '72.5%', Icons.local_shipping_outlined, const Color(0xFFFFE0D3), const Color(0xFFFF6B00)),
                      const SizedBox(width: 12),
                      _buildStatCard('Tasa de Ocupación', '72.5%', '+5.3%', Icons.trending_up, const Color(0xFFD1FAE5), const Color(0xFF10B981)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatCard('Clientes Activos', '156', '+15', Icons.people_outline_rounded, const Color(0xFFFFE0D3), const Color(0xFFFF6B00)),
                      const SizedBox(width: 12),
                      _buildStatCard('Mantenimientos', '12', '-3', Icons.error_outline_rounded, const Color(0xFFFFE0D3), Colors.orange),
                    ],
                  ),
                ],
              ),
            ),

            // 📝 PEDIDOS RECIENTES
            _buildSectionTitle('Pedidos Recientes'),
            _buildRecentOrderCard('PED-2024-0156', 'Constructora López', 'Excavadora Hidráulica', 'Hoy, 10:30 AM', 'En Progreso', Colors.orange),
            _buildRecentOrderCard('PED-2024-0155', 'Inmobiliaria Norte', 'Retroexcavadora', 'Hoy, 09:15 AM', 'Completado', Colors.green),
            _buildRecentOrderCard('PED-2024-0154', 'Obras Civiles S.A.', 'Montacargas 3T', 'Ayer, 4:45 PM', 'En Progreso', Colors.orange),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
    );
  }

  // 1. Cartas del Header con Sombra
  Widget _buildSummaryCard(String title, String value, IconData icon, Color bgColor, Color iconColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: _cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          ],
        ),
      ),
    );
  }

  // 2. Notificaciones con Sombra
  Widget _buildNotificationCard(String title, String desc, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: _cardShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Pagos con Sombra
  Widget _buildPaymentCard(String cliente, String fecha, String monto) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: _cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cliente, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(fecha, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(monto, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('Pendiente', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 4. Estadísticas con Sombra
  Widget _buildStatCard(String title, String value, String percentage, IconData icon, Color bgColor, Color iconColor) {
    bool isPositive = !percentage.contains('-');
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: _cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isPositive ? const Color(0xFFD1FAE5) : const Color(0xFFFFE4E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(percentage, style: TextStyle(color: isPositive ? const Color(0xFF059669) : Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          ],
        ),
      ),
    );
  }

  // 5. Pedidos con Sombra
  Widget _buildRecentOrderCard(String id, String cliente, String equipo, String fecha, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: _cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(cliente, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text(equipo, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(fecha, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}