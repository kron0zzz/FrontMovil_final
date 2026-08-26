class Order {
  final int orderId;
  final String projectName;
  final String customerName;
  final String orderStatusName;
  final String? orderCreationDate;

  Order({
    required this.orderId,
    required this.projectName,
    required this.customerName,
    required this.orderStatusName,
    this.orderCreationDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'] ?? 0,
      projectName: json['project_name'] ?? '',
      customerName: json['customer_name'] ?? '',
      orderStatusName: json['order_status_name'] ?? '',
      orderCreationDate: json['order_creation_date'],
    );
  }
}
