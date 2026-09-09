import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/core/utils/api_parser.dart';
import 'package:flutter_app/core/utils/pagination_controls.dart';
import 'package:flutter_app/data/models/machinery.dart';
import 'package:flutter_app/data/services/api_service.dart';

class MachineryScreen extends StatefulWidget {
  final String token;

  const MachineryScreen({super.key, required this.token});

  @override
  State<MachineryScreen> createState() => _MachineryScreenState();
}

class _MachineryScreenState extends State<MachineryScreen> {
  final _api = ApiService();
  List<Machinery> _items = [];
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
      final response = await _api.get('/machines/table', auth: true, page: page, limit: 10);
      
      if (isPaginatedResponse(response)) {
        final paginated = PaginatedResponse.fromJson(
          response as Map<String, dynamic>,
          Machinery.fromJson,
        );
        setState(() {
          _items = paginated.data;
          _pagination = paginated.pagination;
          _loading = false;
          _error = null;
        });
      } else {
        // Fallback para respuestas legacy
        final items = parseLegacyList(response, Machinery.fromJson);
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Maquinaria',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          PaginationInfoWidget(pagination: _pagination),
          const SizedBox(height: 16),
          if (_loading)
            ...List.generate(4, (i) => _buildSkeleton())
          else if (_error != null)
            _buildError(_error!)
          else
            ..._items.map((item) => _MachineryCard(
                  machinery: item,
                  onTap: () => _showDetails(context, item),
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

  void _showDetails(BuildContext context, Machinery machinery) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.precision_manufacturing, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                machinery.machineryName,
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
            _DetailRow(label: 'Categoría', value: machinery.categoryName, icon: Icons.category),
            const SizedBox(height: 12),
            _DetailRow(
              label: 'Estado',
              value: machinery.statusName.isEmpty ? 'N/A' : machinery.statusName,
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 12),
            _DetailRow(label: 'Stock total', value: '${machinery.stockQuantity} uds', icon: Icons.inventory_2),
            const SizedBox(height: 12),
            _DetailRow(
              label: 'Precio por día',
              value: '\$${machinery.dailyRentalPrice.toStringAsFixed(0)}',
              icon: Icons.attach_money,
            ),
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

class _MachineryCard extends StatelessWidget {
  final Machinery machinery;
  final VoidCallback onTap;

  const _MachineryCard({required this.machinery, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = machinery.statusName == 'Disponible'
        ? const Color(0xFF059669)
        : machinery.statusName == 'Ocupada'
            ? const Color(0xFFDC2626)
            : const Color(0xFFD97706);

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
                      machinery.machineryName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      machinery.categoryName,
                      style: const TextStyle(fontSize: 13, color: AppColors.textLight),
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
                  machinery.statusName,
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
                  'Stock total: ${machinery.stockQuantity} uds',
                  style: const TextStyle(fontSize: 13, color: AppColors.textLight),
                ),
              ),
              Text(
                '\$${machinery.dailyRentalPrice.toStringAsFixed(0)}/día',
                style: const TextStyle(fontSize: 13, color: AppColors.textLight),
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