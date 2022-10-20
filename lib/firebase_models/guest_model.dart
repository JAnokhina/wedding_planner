class GuestModel {
  final String id;
  String key;
  final String name;
  final String email;
  final String cell;
  final String relationship;
  final bool rsvpStatus;

  GuestModel({
    required this.id,
    this.key = 'Guest0',
    required this.name,
    required this.email,
    required this.cell,
    required this.relationship,
    required this.rsvpStatus,
  });

  GuestModel.fromMap(Map<String, dynamic> firestoreMap, String guestKey)
      : id = firestoreMap['id'] ?? '',
        name = firestoreMap['name'] ?? '',
        key = guestKey,
        cell = firestoreMap['cell'] ?? '',
        email = firestoreMap['email'] ?? '',
        relationship = firestoreMap['relationship'] ?? '',
        rsvpStatus = firestoreMap['rsvpStatus'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      if (name.isNotEmpty) 'name': name,
      if (cell.isNotEmpty) 'cell': cell,
      if (email.isNotEmpty) 'email': email,
      if (relationship.isNotEmpty) 'relationship': relationship,
      'rsvpStatus': rsvpStatus,
    };
  }
}

class GuestListsModel {
  final String id;
  final List<GuestModel> guestList;

  GuestListsModel({
    required this.id,
    required this.guestList,
  });

  // GuestListsModel.fromMap(Map<String, dynamic> data, String docId)
  // : id = docId,
  // guestList = List<GuestModel>

  // GuestListsModel.fromMap(Map<String, dynamic> firestoreMap, String docId)
  // : id = docId,
  // guestList = firestoreMap[]
}