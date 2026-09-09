import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/core/utils/api_parser.dart';
import 'package:flutter_app/core/utils/pagination_controls.dart';
import 'package:flutter_app/data/models/order.dart';
import 'package:flutter_app/data/services/api_service.dart';

class OrdersScreen extends StatefulWidget {
  final String token;

  const OrdersScreen({super.key, required this.token});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _api = ApiService();
  List<Order> _items = [];
  bool _loading = true;
  String? _error;
  PaginationInfo _pagination = PaginationInfo(page: 1, limit: 10, total: 0, totalPages: 1);

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems({int page = 1}) async {
    try {
      setState(() => _loading = true);
      final response = await _api.get('/orders/table', auth: true, page: page, limit: 10);
      
      if (isPaginatedResponse(response)) {
        final paginated = PaginatedResponse.fromJson(
          response as Map<String, dynamic>,
          Order.fromJson,
        );
        setState(() {
          _items = paginated.data;
          _pagination = paginated.pagination;
          _loading = false;
          _error = null;
        });
      } else {
        // Fallback para respuestas legacy
        final items = parseLegacyList(response, Order.fromJson);
        setState(() {
          _items = items;
          _pagination = _pagination.copyWith(total: items.length, totalPages: 1);
          _loading = false;
          _error = null;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _loading = false;
      });
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    final date = DateTime.parse(dateStr);
    return '${date.day.toString().padLeft(2, '0')} ${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pedidos',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          PaginationInfoWidget(pagination: _pagination),
          const SizedBox(height: 16),
          if (_loading)
            ...List.generate(4, (i) => _buildSkeleton())
          else if (_error != null)
            _buildError(_error!)
          else
            ..._items.map((item) => _OrderCard(
                  order: item,
                  onTap: () => _showDetails(context, item),
                  formatDate: _formatDate,
                )),
          const SizedBox(height: 16),
          PaginationControls(
            pagination: _pagination,
            onPageChanged: (page) => _loadItems(page: page),
            isLoading: _loading,
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 120, height: 16, color: AppColors.border),
          const SizedBox(height: 8),
          Container(width: 80, height: 12, color: AppColors.border),
        ],
      ),
    );
  }

  Widget _buildError(String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Text(error, style: const TextStyle(color: Color(0xFFB91C1C))),
    );
  }

  void _showDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.receipt_long, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pedido #${order.orderId}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow(label: 'Proyecto', value: order.projectName, icon: Icons.engineering),
            const SizedBox(height: 12),
            _DetailRow(label: 'Cliente', value: order.customerName, icon: Icons.person),
            const SizedBox(height: 12),
            _DetailRow(label: 'Estado', value: order.orderStatusName, icon: Icons.info_outline),
            const SizedBox(height: 12),
            _DetailRow(label: 'Fecha', value: _formatDate(order.orderCreationDate), icon: Icons.calendar_today),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(ctx),
            icon: const Icon(Icons.close, size: 18),
            label: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;
  final String Function(String?) formatDate;

  const _OrderCard({
    required this.order,
    required this.onTap,
    required this.formatDate,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Creado':
        return const Color(0xFF3B82F6);
      case 'En proceso':
        return const Color(0xFFD97706);
      case 'Cerrado':
        return const Color(0xFF059669);
      case 'Cancelado':
        return const Color(0xFFDC2626);
      default:
        return AppColors.textLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.orderStatusName);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pedido #${order.orderId}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.projectName,
                      style: TextStyle(fontSize: 13, color: AppColors.textLight),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  order.orderStatusName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Cliente: ${order.customerName}',
                  style: TextStyle(fontSize: 13, color: AppColors.textLight),
                ),
              ),
              Text(
                formatDate(order.orderCreationDate),
                style: TextStyle(fontSize: 13, color: AppColors.textLight),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.accentSoft,
                foregroundColor: AppColors.accent,
              ),
               child: const Text('Ver detalles'),
              ),
            ),
          ],
        ),
      );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textLight),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
