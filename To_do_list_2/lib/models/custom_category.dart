class CustomCategory {
  String id;
  String name;
  String iconName;

  CustomCategory({
    required this.id,
    required this.name,
    this.iconName = 'label',
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
    };
  }

  // Create from JSON
  factory CustomCategory.fromJson(Map<String, dynamic> json) {
    return CustomCategory(
      id: json['id'],
      name: json['name'],
      iconName: json['iconName'] ?? 'label',
    );
  }
}
