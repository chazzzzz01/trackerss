class Category {
  final String id;
  final String name;
  final String? icon;
  final String? color;

  Category({
    required this.id,
    required this.name,
    this.icon,
    this.color,
  });
}
