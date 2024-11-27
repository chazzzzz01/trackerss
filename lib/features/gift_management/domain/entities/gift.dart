import 'package:equatable/equatable.dart';

class Gift extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final String recipientId;
  final DateTime occasionDate;
  final String status;
  final double? price;
  final String? notes;

  const Gift({
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

  Gift copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? recipientId,
    DateTime? occasionDate,
    String? status,
    double? price,
    String? notes,
  }) {
    return Gift(
      id: id?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      recipientId: recipientId ?? this.recipientId,
      occasionDate: occasionDate ?? this.occasionDate,
      status: status ?? this.status,
      price: price ?? this.price,
      notes: notes ?? this.notes,

    );
  }
    @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        recipientId,
        occasionDate,
        status,
        price,
        notes,
      ];
}
