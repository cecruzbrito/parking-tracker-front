class UserAuthEntity {
  final int idUser;
  final String token;

  Map<String, String> get authInHeader => {"authorization": "Bearer $token"};

  UserAuthEntity({required this.idUser, required this.token});
}
