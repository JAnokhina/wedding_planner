class BudgetModel {
  double total;
  double venueAndFood;
  double photos;
  double music;
  double flowers;
  double decor;
  double attire;
  double transport;
  double stationary;
  double favours;
  double cake;

  BudgetModel({
    required this.total,
    required this.venueAndFood,
    required this.photos,
    required this.music,
    required this.flowers,
    required this.decor,
    required this.attire,
    required this.transport,
    required this.stationary,
    required this.favours,
    required this.cake,
  });

  Map<String, dynamic> toMap() {
    return {
      if (total != 0) 'total': total,
      'venueAndFood': (total * 0.4),
      'photos': (total * 0.15),
      'music': (total * 0.1),
      'flowers': (total * 0.1),
      'decor': (total * 0.1),
      'attire': (total * 0.05),
      'transport': (total * 0.03),
      'stationary': (total * 0.02),
      'favours': (total * 0.02),
      'cake': (total * 0.02),
    };
  }

  BudgetModel.fromMap(Map<String, dynamic> firestoreMap)
      : total = firestoreMap['total'],
        venueAndFood = firestoreMap['venueAndFood'],
        photos = firestoreMap['photos'],
        music = firestoreMap['music'],
        flowers = firestoreMap['flowers'],
        decor = firestoreMap['decor'],
        attire = firestoreMap['attire'],
        transport = firestoreMap['transport'],
        stationary = firestoreMap['stationary'],
        favours = firestoreMap['favours'],
        cake = firestoreMap['cake'];
}