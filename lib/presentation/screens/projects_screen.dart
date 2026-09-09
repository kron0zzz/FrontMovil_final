import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/core/utils/api_parser.dart';
import 'package:flutter_app/core/utils/pagination_controls.dart';
import 'package:flutter_app/data/models/project.dart';
import 'package:flutter_app/data/services/api_service.dart';

class ProjectsScreen extends StatefulWidget {
  final String token;

  const ProjectsScreen({super.key, required this.token});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _api = ApiService();
  List<Project> _items = [];
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
      final response = await _api.get('/projects/table', auth: true, page: page, limit: 10);
      
      if (isPaginatedResponse(response)) {
        final paginated = PaginatedResponse.fromJson(
          response as Map<String, dynamic>,
          Project.fromJson,
        );
        setState(() {
          _items = paginated.data;
          _pagination = paginated.pagination;
          _loading = false;
          _error = null;
        });
      } else {
        // Fallback para respuestas legacy
        final items = parseLegacyList(response, Project.fromJson);
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
          Text(
            'Proyectos',
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
            ..._items.map((item) => _ProjectCard(
                  project: item,
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

  void _showDetails(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.engineering, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                project.projectName,
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
            _DetailRow(label: 'Ciudad', value: project.projectCity, icon: Icons.location_city),
            const SizedBox(height: 12),
            _DetailRow(label: 'Teléfono', value: project.projectPhone, icon: Icons.phone),
            const SizedBox(height: 12),
            _DetailRow(label: 'Cliente ID', value: '#${project.customerId}', icon: Icons.person),
            const SizedBox(height: 12),
            _DetailRow(
              label: 'Estado',
              value: project.projectStatus ? 'Activo' : 'Inactivo',
              icon: project.projectStatus ? Icons.check_circle : Icons.cancel,
              valueColor: project.projectStatus ? const Color(0xFF059669) : const Color(0xFFDC2626),
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

class _ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const _ProjectCard({required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                      project.projectName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.projectCity,
                      style: TextStyle(fontSize: 13, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: project.projectStatus
                      ? const Color(0xFF059669).withOpacity(0.1)
                      : const Color(0xFFDC2626).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: project.projectStatus
                        ? const Color(0xFF059669).withOpacity(0.3)
                        : const Color(0xFFDC2626).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  project.projectStatus ? 'Activo' : 'Inactivo',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: project.projectStatus
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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tel: ${project.projectPhone}',
                  style: TextStyle(fontSize: 13, color: AppColors.textLight),
                ),
              ),
              Text(
                'Cliente: #${project.customerId}',
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
