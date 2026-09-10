class Machinery {
  final int machineryId;
  final int categoryId;
  final String machineryName;
  final String machineryDescription;
  final bool isMotorized;
  final double salePrice;
  final double dailyRentalPrice;
  final double weightKg;
  final String categoryName;
  final int totalStock;
  final int availableStock;
  final String statusName;

  Machinery({
    required this.machineryId,
    required this.categoryId,
    required this.machineryName,
    required this.machineryDescription,
    required this.isMotorized,
    required this.salePrice,
    required this.dailyRentalPrice,
    required this.weightKg,
    required this.categoryName,
    required this.totalStock,
    required this.availableStock,
    required this.statusName,
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
    final availableStock = json['available_stock'];
    final salePrice = json['sale_price'];
    final weightKg = json['weight_kg'];

    return Machinery(
      machineryId: json['machinery_id'] is num ? (json['machinery_id'] as num).toInt() : int.tryParse(json['machinery_id']?.toString() ?? '') ?? 0,
      categoryId: json['category_id'] is num ? (json['category_id'] as num).toInt() : int.tryParse(json['category_id']?.toString() ?? '') ?? 0,
      machineryName: json['machinery_name']?.toString() ?? '',
      machineryDescription: json['machinery_description']?.toString() ?? '',
      isMotorized: json['is_motorized'] == true || json['is_motorized'] == 1 || json['is_motorized'] == 'true',
      salePrice: salePrice is String ? double.tryParse(salePrice) ?? 0.0 : (salePrice is num ? salePrice.toDouble() : 0.0),
      dailyRentalPrice: dailyRentalPrice,
      weightKg: weightKg is String ? double.tryParse(weightKg) ?? 0.0 : (weightKg is num ? weightKg.toDouble() : 0.0),
      categoryName: json['category_name']?.toString() ?? '',
      totalStock: totalStock is num ? totalStock.toInt() : (totalStock is String ? int.tryParse(totalStock) ?? 0 : 0),
      availableStock: availableStock is num ? availableStock.toInt() : (availableStock is String ? int.tryParse(availableStock) ?? 0 : 0),
      statusName: statusName,
    );
  }
}
