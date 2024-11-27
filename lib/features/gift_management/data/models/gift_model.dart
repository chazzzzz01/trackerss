import 'dart:convert';

import 'package:trackerss/features/gift_management/domain/entities/gift.dart';

class GiftModel extends Gift {
  const GiftModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.recipientId,
    required super.occasionDate,
    required super.status,
    super.price,
    super.notes,
  });

  /// Creates a `GiftModel` from a `Map<String, dynamic>`
  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      recipientId: map['recipientId'] as String,
      occasionDate: DateTime.parse(map['occasionDate'] as String),
      status: map['status'] as String,
      price: (map['price'] as num?)?.toDouble(),
      notes: map['notes'] as String?,
    );
  }

  /// Creates a `GiftModel` from a JSON string
  factory GiftModel.fromJson(String source) {
    return GiftModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  /// Converts the `GiftModel` to a `Map<String, dynamic>`
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'recipientId': recipientId,
      'occasionDate': occasionDate.toIso8601String(),
      'status': status,
      'price': price,
      'notes': notes,
    };
  }

  /// Converts the `GiftModel` to a JSON string
  String toJson() {
    return json.encode(toMap());
  }
}
