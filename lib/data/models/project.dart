class Project {
  final int projectId;
  final int customerId;
  final String projectName;
  final String? projectAddress;
  final String projectPhone;
  final String projectCity;
  final bool projectStatus;
  final String customerName;

  Project({
    required this.projectId,
    required this.customerId,
    required this.projectName,
    this.projectAddress,
    required this.projectPhone,
    required this.projectCity,
    required this.projectStatus,
    required this.customerName,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'] is num ? (json['project_id'] as num).toInt() : int.tryParse(json['project_id']?.toString() ?? '') ?? 0,
      customerId: json['customer_id'] is num ? (json['customer_id'] as num).toInt() : int.tryParse(json['customer_id']?.toString() ?? '') ?? 0,
      projectName: json['project_name']?.toString() ?? '',
      projectAddress: json['project_address']?.toString(),
      projectPhone: json['project_phone']?.toString() ?? '',
      projectCity: json['project_city']?.toString() ?? '',
      projectStatus: json['project_status'] == true || json['project_status'] == 1 || json['project_status'] == 'true',
      customerName: json['customer_name']?.toString() ?? '',
    );
  }
}
