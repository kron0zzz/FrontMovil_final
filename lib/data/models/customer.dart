class Customer {
  final int customerId;
  final String customerName;
  final String documentNumber;
  final bool status;

  Customer({
    required this.customerId,
    required this.customerName,
    required this.documentNumber,
    required this.status,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    final customerId = json['customer_id'];
    final parsedId = customerId is num ? customerId.toInt() : int.tryParse(customerId?.toString() ?? '') ?? 0;

    final customerStatus = json['customer_status'];
    final status = customerStatus is bool ? customerStatus : (customerStatus == 1 || customerStatus == 'true');

    return Customer(
      customerId: parsedId,
      customerName: json['customer_name']?.toString() ?? '',
      documentNumber: json['customer_document_number']?.toString() ?? '',
      status: status,
    );
  }
}
