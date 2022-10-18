class GuestModel {
  final String id;
  final String name;
  final String email;
  final String cell;
  final Enum relationship;
  final bool rsvpStatus;

  GuestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cell,
    required this.relationship,
    required this.rsvpStatus,
  });

  GuestModel.fromMap(Map<String, dynamic> firestoreMap, String docId)
      : id = docId,
        name = firestoreMap['name'] ?? '',
        cell = firestoreMap['cell'] ?? '',
        email = firestoreMap['email'] ?? '',
        relationship = firestoreMap['relationship'] ?? '',
        rsvpStatus = firestoreMap['rsvpStatus'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cell': cell,
      'email': email,
      'relationship': relationship,
      'rsvpStatus': rsvpStatus,
    };
  }
}