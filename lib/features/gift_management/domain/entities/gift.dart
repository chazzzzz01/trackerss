class Gift {
  final String id;
  final String name;
  final String description;
  final String category;
  final String recipientId;
  final DateTime occasionDate;
  final String status;
  final double? price;
  final String? notes;

  Gift({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.recipientId,
    required this.occasionDate,
    required this.status,
    this.price,
    this.notes,
  });
}
