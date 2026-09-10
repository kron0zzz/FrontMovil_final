class Order {
  final int orderId;
  final int projectId;
  final int orderStatusId;
  final int userId;
  final int customerId;
  final String? orderCreationDate;
  final String? orderClosingDate;
  final double discountAmount;
  final String? orderDescription;
  final String? lastCutDate;
  final String cutFrequency;
  final String orderStatusName;
  final String projectName;
  final String? projectAddress;
  final String projectPhone;
  final String projectCity;
  final String customerName;
  final String customerPhone;
  final String userEmail;

  Order({
    required this.orderId,
    required this.projectId,
    required this.orderStatusId,
    required this.userId,
    required this.customerId,
    this.orderCreationDate,
    this.orderClosingDate,
    required this.discountAmount,
    this.orderDescription,
    this.lastCutDate,
    required this.cutFrequency,
    required this.orderStatusName,
    required this.projectName,
    this.projectAddress,
    required this.projectPhone,
    required this.projectCity,
    required this.customerName,
    required this.customerPhone,
    required this.userEmail,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final discount = json['discount_amount'];
    return Order(
      orderId: json['order_id'] is num ? (json['order_id'] as num).toInt() : int.tryParse(json['order_id']?.toString() ?? '') ?? 0,
      projectId: json['project_id'] is num ? (json['project_id'] as num).toInt() : int.tryParse(json['project_id']?.toString() ?? '') ?? 0,
      orderStatusId: json['order_status_id'] is num ? (json['order_status_id'] as num).toInt() : int.tryParse(json['order_status_id']?.toString() ?? '') ?? 0,
      userId: json['user_id'] is num ? (json['user_id'] as num).toInt() : int.tryParse(json['user_id']?.toString() ?? '') ?? 0,
      customerId: json['customer_id'] is num ? (json['customer_id'] as num).toInt() : int.tryParse(json['customer_id']?.toString() ?? '') ?? 0,
      orderCreationDate: json['order_creation_date']?.toString(),
      orderClosingDate: json['order_closing_date']?.toString(),
      discountAmount: discount is String ? double.tryParse(discount) ?? 0.0 : (discount is num ? discount.toDouble() : 0.0),
      orderDescription: json['order_description']?.toString(),
      lastCutDate: json['last_cut_date']?.toString(),
      cutFrequency: json['cut_frequency']?.toString() ?? '',
      orderStatusName: json['order_status_name']?.toString() ?? '',
      projectName: json['project_name']?.toString() ?? '',
      projectAddress: json['project_address']?.toString(),
      projectPhone: json['project_phone']?.toString() ?? '',
      projectCity: json['project_city']?.toString() ?? '',
      customerName: json['customer_name']?.toString() ?? '',
      customerPhone: json['customer_phone']?.toString() ?? '',
      userEmail: json['user_email']?.toString() ?? '',
    );
  }
}
