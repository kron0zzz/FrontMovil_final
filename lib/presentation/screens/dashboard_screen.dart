import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/data/services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  final String token;

  const DashboardScreen({super.key, required this.token});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _api = ApiService();
  int _machinery = 0;
  int _projects = 0;
  int _orders = 0;
  int _customers = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final results = await Future.wait([
        _api.get('/machines/table', auth: true),
        _api.get('/projects/table', auth: true),
        _api.get('/orders/table', auth: true),
        _api.get('/customers/table', auth: true),
      ]);

      int extractCount(dynamic response) {
        dynamic rawList;
        if (response is List) {
          rawList = response;
        } else if (response is Map<String, dynamic>) {
          rawList = response['data'];
          if (rawList is Map<String, dynamic>) {
            rawList = rawList['rows'] ??
                rawList['machines'] ??
                rawList['projects'] ??
                rawList['orders'] ??
                rawList['customers'] ??
                rawList['result'] ??
                rawList['items'] ??
                [];
          } else if (rawList == null) {
            rawList = response['machines'] ??
                response['projects'] ??
                response['orders'] ??
                response['customers'] ??
                response['result'] ??
                response['rows'] ??
                response['items'] ??
                [];
          }
        }
        return rawList is List ? rawList.length : 0;
      }

      setState(() {
        _machinery = extractCount(results[0]);
        _projects = extractCount(results[1]);
        _orders = extractCount(results[2]);
        _customers = extractCount(results[3]);
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Resumen general del sistema',
            style: TextStyle(fontSize: 14, color: AppColors.textLight),
          ),
          const SizedBox(height: 24),
          if (_loading)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: List.generate(4, (i) => _buildSkeleton()),
            )
          else
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _StatCard(
                  title: 'Maquinaria',
                  value: _machinery.toString(),
                  subtitle: 'Registros activos',
                  icon: Icons.precision_manufacturing,
                  color: AppColors.primary,
                ),
                _StatCard(
                  title: 'Proyectos',
                  value: _projects.toString(),
                  subtitle: 'En gestión',
                  icon: Icons.engineering,
                  color: AppColors.primaryLight,
                ),
                _StatCard(
                  title: 'Pedidos',
                  value: _orders.toString(),
                  subtitle: 'Total registrados',
                  icon: Icons.receipt_long,
                  color: AppColors.accent,
                ),
                _StatCard(
                  title: 'Clientes',
                  value: _customers.toString(),
                  subtitle: 'Registrados',
                  icon: Icons.people,
                  color: AppColors.primary,
                ),
                _StatCard(
                  title: 'Total General',
                  value: (_machinery + _projects + _orders + _customers).toString(),
                  subtitle: 'Registros',
                  icon: Icons.data_usage,
                  color: AppColors.accent,
                  isFull: true,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 60, height: 12, color: AppColors.border),
          const SizedBox(height: 12),
          Container(width: 80, height: 28, color: AppColors.border),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isFull;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isFull = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLight,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
