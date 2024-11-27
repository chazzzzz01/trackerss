import 'dart:convert';

import 'package:trackerss/features/recipient_management/domain/entities/recipient.dart';

class RecipientModel extends Recipient {
  const RecipientModel({
    required super.id,
    required super.name,
    required super.contactDetails,
    super.notes,
  });

  /// Creates a `RecipientModel` from a `Map<String, dynamic>`
  factory RecipientModel.fromMap(Map<String, dynamic> map) {
    return RecipientModel(
      id: map['id'] as String,
      name: map['name'] as String,
      contactDetails: map['contactDetails'] as String,
      notes: map['notes'] as String?,
    );
  }

  /// Creates a `RecipientModel` from a JSON string
  factory RecipientModel.fromJson(String source) {
    return RecipientModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  /// Converts the `RecipientModel` to a `Map<String, dynamic>`
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contactDetails': contactDetails,
      'notes': notes,
    };
  }

  /// Converts the `RecipientModel` to a JSON string
  String toJson() {
    return json.encode(toMap());
  }
}
