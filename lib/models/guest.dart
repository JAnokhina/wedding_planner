class Guest {
  final int id;
  final String name;
  final String email;
  final String cell;
  final Enum relationship;
  final bool rsvpStatus;

  Guest({
    required this.id,
    required this.name,
    required this.email,
    required this.cell,
    required this.relationship,
    required this.rsvpStatus,
  });
}