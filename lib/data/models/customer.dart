class Customer {
  final int customerId;
  final String organizationType;
  final String customerDocumentType;
  final String customerDocumentNumber;
  final bool customerStatus;
  final String customerName;
  final String legalRepresentative;
  final String? customerAddress;
  final String customerPhone;
  final String? customerEmail;

  Customer({
    required this.customerId,
    required this.organizationType,
    required this.customerDocumentType,
    required this.customerDocumentNumber,
    required this.customerStatus,
    required this.customerName,
    required this.legalRepresentative,
    this.customerAddress,
    required this.customerPhone,
    this.customerEmail,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    final customerId = json['customer_id'];
    final parsedId = customerId is num ? customerId.toInt() : int.tryParse(customerId?.toString() ?? '') ?? 0;

    final customerStatus = json['customer_status'];
    final status = customerStatus is bool ? customerStatus : (customerStatus == 1 || customerStatus == 'true');

    return Customer(
      customerId: parsedId,
      organizationType: json['organization_type']?.toString() ?? '',
      customerDocumentType: json['customer_document_type']?.toString() ?? '',
      customerDocumentNumber: json['customer_document_number']?.toString() ?? '',
      customerStatus: status,
      customerName: json['customer_name']?.toString() ?? '',
      legalRepresentative: json['legal_representative']?.toString() ?? '',
      customerAddress: json['customer_address']?.toString(),
      customerPhone: json['customer_phone']?.toString() ?? '',
      customerEmail: json['customer_email']?.toString(),
    );
  }
}
