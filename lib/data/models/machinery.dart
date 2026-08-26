class Machinery {
  final int machineryId;
  final String machineryName;
  final String categoryName;
  final String statusName;
  final int stockQuantity;
  final double dailyRentalPrice;

  Machinery({
    required this.machineryId,
    required this.machineryName,
    required this.categoryName,
    required this.statusName,
    required this.stockQuantity,
    required this.dailyRentalPrice,
  });

  factory Machinery.fromJson(Map<String, dynamic> json) {
    final stockDetails = json['stock_details'];
    final detailsList = stockDetails is List ? stockDetails : null;
    final firstDetail = detailsList != null && detailsList.isNotEmpty && detailsList.first is Map
        ? detailsList.first as Map<String, dynamic>
        : null;
    final statusName = firstDetail != null
        ? (firstDetail['status_name']?.toString() ?? '')
        : '';

    final dailyRental = json['daily_rental_price'];
    final dailyRentalPrice = dailyRental is String
        ? double.tryParse(dailyRental) ?? 0.0
        : (dailyRental is num ? dailyRental.toDouble() : 0.0);

    final totalStock = json['total_stock'];
    final stockQuantity = totalStock is num ? totalStock.toInt() : (totalStock is String ? int.tryParse(totalStock) ?? 0 : 0);

    return Machinery(
      machineryId: json['machinery_id'] is num ? (json['machinery_id'] as num).toInt() : int.tryParse(json['machinery_id']?.toString() ?? '') ?? 0,
      machineryName: json['machinery_name']?.toString() ?? '',
      categoryName: json['category_name']?.toString() ?? '',
      statusName: statusName,
      stockQuantity: stockQuantity,
      dailyRentalPrice: dailyRentalPrice,
    );
  }
}
