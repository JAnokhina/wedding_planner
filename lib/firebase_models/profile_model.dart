class ProfileModel {
  Partner partner1;
  Partner partner2;
  DateTime weddingDate;

  ProfileModel({
    required this.partner1,
    required this.partner2,
    required this.weddingDate,
  });

  Map<String, dynamic> createMap() {
    return {
      'Partner 1': partner1.createMap(),
      'Partner 2': partner2.createMap(),
      'Wedding Date': weddingDate,
    };
  }

  ProfileModel.fromMap(Map<String, dynamic> firestoreMap)
      : partner1 = Partner.fromFirestore(firestoreMap['Partner 1']),
        partner2 = Partner.fromFirestore(firestoreMap['Partner 2']),
        weddingDate = firestoreMap['Wedding Date'].toDate();
}

class Partner {
  String name;
  String status;

  Partner({
    required this.name,
    required this.status,
  });

  Map<String, dynamic> createMap() {
    return {
      if (name.isNotEmpty) 'name': name,
      if (status.isNotEmpty) 'status': status,
    };
  }

  Partner.fromFirestore(Map<String, dynamic> firestoreMap)
      : name = firestoreMap['name'],
        status = firestoreMap['status'];
}