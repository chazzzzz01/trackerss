import 'package:equatable/equatable.dart';

class Recipient extends Equatable {
  final String id;
  final String name;
  final String contactDetails;
  final String? notes;

  const Recipient({
    required this.id,
    required this.name,
    required this.contactDetails,
    this.notes,
  });

  Recipient copyWith({
    String? id,
    String? name,
    String? contactDetails,
    String? notes,
  }) {
    return Recipient(
      id: id ?? this.id,
      name: name ?? this.name,
      contactDetails: contactDetails ?? this.contactDetails,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [id, name, contactDetails, notes];
}
