import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/core/utils/api_parser.dart';

typedef OnPageChanged = void Function(int page);

class PaginationControls extends StatelessWidget {
  final PaginationInfo pagination;
  final OnPageChanged onPageChanged;
  final bool isLoading;

  const PaginationControls({
    super.key,
    required this.pagination,
    required this.onPageChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (pagination.totalPages <= 1) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botón Primera página
            _PageButton(
              icon: Icons.first_page,
              onPressed: pagination.hasPreviousPage && !isLoading
                  ? () => onPageChanged(1)
                  : null,
              tooltip: 'Primera página',
            ),
            const SizedBox(width: 8),
            
            // Botón Anterior
            _PageButton(
              icon: Icons.chevron_left,
              onPressed: pagination.hasPreviousPage && !isLoading
                  ? () => onPageChanged(pagination.page - 1)
                  : null,
              tooltip: 'Página anterior',
            ),
            const SizedBox(width: 16),
            
            // Indicador de página actual
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Text(
                'Página ${pagination.page} de ${pagination.totalPages}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Botón Siguiente
            _PageButton(
              icon: Icons.chevron_right,
              onPressed: pagination.hasNextPage && !isLoading
                  ? () => onPageChanged(pagination.page + 1)
                  : null,
              tooltip: 'Página siguiente',
            ),
            const SizedBox(width: 8),
            
            // Botón Última página
            _PageButton(
              icon: Icons.last_page,
              onPressed: pagination.hasNextPage && !isLoading
                  ? () => onPageChanged(pagination.totalPages)
                  : null,
              tooltip: 'Última página',
            ),
          ],
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  const _PageButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, size: 24),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: onPressed != null 
              ? AppColors.primary.withValues(alpha: 0.1) 
              : AppColors.border,
          foregroundColor: onPressed != null ? AppColors.primary : AppColors.textLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}

/// Widget que muestra información de paginación (total de registros, etc.)
class PaginationInfoWidget extends StatelessWidget {
  final PaginationInfo pagination;

  const PaginationInfoWidget({super.key, required this.pagination});

  @override
  Widget build(BuildContext context) {
    final start = ((pagination.page - 1) * pagination.limit) + 1;
    final end = pagination.page * pagination.limit;
    final actualEnd = end > pagination.total ? pagination.total : end;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        'Mostrando $start - $actualEnd de ${pagination.total} registros',
        style: TextStyle(fontSize: 12, color: AppColors.textLight),
      ),
    );
  }
}