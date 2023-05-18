class SelectorProfileListUsers {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  SelectorProfileListUsers(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar});

  @override
  // ignore: hash_and_equals
  bool operator ==(other) =>
      other is SelectorProfileListUsers && other.id == id;
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      avatar.hashCode;
}
