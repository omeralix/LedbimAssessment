class AuthUser {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  AuthUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory  AuthUser.fromJson(Map<String,dynamic> user){
    return AuthUser(
      id: user["id"],
      email: user["email"],
      firstName: user["first_name"],
      lastName: user["last_name"],
      avatar: user["avatar"],
    );
  }}