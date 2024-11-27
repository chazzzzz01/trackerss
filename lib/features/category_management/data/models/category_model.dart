import 'dart:convert';

import 'package:trackerss/features/category_management/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.icon,
    super.color,
  });

  /// Creates a `CategoryModel` from a `Map<String, dynamic>`
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String?,
      color: map['color'] as String?,
    );
  }

  /// Creates a `CategoryModel` from a JSON string
  factory CategoryModel.fromJson(String source) {
    return CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  /// Converts the `CategoryModel` to a `Map<String, dynamic>`
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }

  /// Converts the `CategoryModel` to a JSON string
  String toJson() {
    return json.encode(toMap());
  }
}
