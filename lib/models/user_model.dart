class User {
  final int? id;
  final String name;
  final String surname;
  final String birthDate;
  final String email;
  final String password;
  final String userType;

  User({
    this.id,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.email,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      'email': email,
      'password': password,
      'userType': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      birthDate: map['birthDate'],
      email: map['email'],
      password: map['password'],
      userType: map['userType'],
    );
  }
}
