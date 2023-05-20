class Stadium {
  final String name;
  final String type;
  final String id;
  final bool active;
  final String image;
  final int? displayOrder;
  Stadium({
    required this.name,
    required this.type,
    required this.id,
    required this.active,
    required this.image,
    this.displayOrder,
  });

  factory Stadium.fromJson(Map<String, dynamic> json, String? id) {
    return Stadium(
      id: id ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      active: json['active'] ?? true,
      displayOrder: json['displayOrder'],
    );
  }
}
