class Recipient {
  final String id;
  final String name;
  final String contactDetails;
  final String? notes;

  Recipient({
    required this.id,
    required this.name,
    required this.contactDetails,
    this.notes,
  });
}
