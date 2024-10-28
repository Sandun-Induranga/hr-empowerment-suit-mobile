class Project {
  final String id;
  final String name;
  final String description;
  final List<String> users;
  final DateTime createdAt;
  final String status;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.users,
    required this.createdAt,
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      users: List<String>.from(json['users'] ?? []),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'users': users,
      'created_at': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
