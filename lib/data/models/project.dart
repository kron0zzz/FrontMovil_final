class Project {
  final int projectId;
  final String projectName;
  final String projectCity;
  final bool projectStatus;
  final String projectPhone;
  final int customerId;

  Project({
    required this.projectId,
    required this.projectName,
    required this.projectCity,
    required this.projectStatus,
    required this.projectPhone,
    required this.customerId,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'] ?? 0,
      projectName: json['project_name'] ?? '',
      projectCity: json['project_city'] ?? '',
      projectStatus: json['project_status'] ?? false,
      projectPhone: json['project_phone'] ?? '',
      customerId: json['customer_id'] ?? 0,
    );
  }
}
