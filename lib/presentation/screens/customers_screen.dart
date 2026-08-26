import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/data/models/customer.dart';
import 'package:flutter_app/data/services/api_service.dart';

class CustomersScreen extends StatefulWidget {
  final String token;

  const CustomersScreen({super.key, required this.token});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final _api = ApiService();
  List<Customer> _items = [];
  bool _loading = true;
  String? _error;
  Customer? _selected;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final data = await _api.get('/customers/table', auth: true);
      dynamic rawList;

      if (data is List) {
        rawList = data;
      } else if (data is Map<String, dynamic>) {
        rawList = data['data'];
        if (rawList is Map<String, dynamic>) {
          rawList = rawList['rows'] ??
              rawList['customers'] ??
              rawList['result'] ??
              rawList['items'] ??
              [];
        } else if (rawList == null) {
          rawList = data['customers'] ??
              data['result'] ??
              data['rows'] ??
              data['items'] ??
              [];
        }
      } else {
        rawList = [];
      }

      if (rawList is List) {
        final parsedItems = rawList.map<Customer>((e) {
          if (e is Customer) return e;
          final map = e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map);
          return Customer.fromJson(map);
        }).toList();

        setState(() {
          _items = parsedItems;
          _loading = false;
          _error = null;
        });
      } else {
        setState(() {
          _items = [];
          _loading = false;
          _error = 'Formato no soportado: ${data.runtimeType}';
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
          Text(
            'Clientes',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${_items.length} registros encontrados',
            style: TextStyle(fontSize: 14, color: AppColors.textLight),
          ),
          const SizedBox(height: 16),
          if (_loading)
            ...List.generate(4, (i) => _buildSkeleton())
          else if (_error != null)
            _buildError(_error!)
          else
            ..._items.map((item) => _CustomerCard(
                  customer: item,
                  onTap: () => _showDetails(context, item),
                )),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, Customer customer) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.person, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                customer.customerName,
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
            _DetailRow(label: 'Documento', value: customer.documentNumber, icon: Icons.badge),
            const SizedBox(height: 12),
            _DetailRow(
              label: 'Estado',
              value: customer.status ? 'Activo' : 'Inactivo',
              icon: customer.status ? Icons.check_circle : Icons.cancel,
              valueColor: customer.status ? const Color(0xFF059669) : const Color(0xFFDC2626),
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
      child: Text(error, style: const TextStyle(color: const Color(0xFFB91C1C))),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  final Customer customer;
  final VoidCallback onTap;

  const _CustomerCard({required this.customer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final displayContact = customer.customerName;

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
                      customer.customerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Doc: ${customer.documentNumber}',
                      style: TextStyle(fontSize: 13, color: AppColors.textLight),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: customer.status
                      ? const Color(0xFF059669).withOpacity(0.1)
                      : const Color(0xFFDC2626).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: customer.status
                        ? const Color(0xFF059669).withOpacity(0.3)
                        : const Color(0xFFDC2626).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  customer.status ? 'Activo' : 'Inactivo',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: customer.status
                        ? const Color(0xFF059669)
                        : const Color(0xFFDC2626),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.border),
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
