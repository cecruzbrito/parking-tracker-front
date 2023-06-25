import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserCredentialModel extends UserCredentialEntity {
  UserCredentialModel({required super.email, required super.nome});

  factory UserCredentialModel.fromGoogleAuth(GoogleSignInAccount googleSingInAccount) =>
      UserCredentialModel(email: googleSingInAccount.email, nome: googleSingInAccount.displayName);
}
