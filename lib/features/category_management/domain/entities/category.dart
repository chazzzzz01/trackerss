
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? icon;
  final String? color;

  const Category({
    required this.id,
    required this.name,
    this.color,
    this.icon,
    
  });

 

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    String? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [id, name, icon, color];
}
