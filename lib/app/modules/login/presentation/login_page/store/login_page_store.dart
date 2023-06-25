import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/usecases/social_login/social_auth_usecase_google_auth_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../state/login_page_state.dart';

class LoginPageStore extends Store<LoginPageState> {
  LoginPageStore(this._socialAuthGoogle) : super(LoginPageState.initialState);

  final SocialAuthUsecaseGoogleAuthImp _socialAuthGoogle;

  final ctrEmail = TextEditingController();

  final ctrPassword = TextEditingController();

  Future<void> onTapInSignUpGoogle() async {
    setLoading(true);
    final response = await _socialAuthGoogle();
    setLoading(false);
    response.fold((l) => null, _signUp);
  }

  void _signUp(UserCredentialEntity? user) => Modular.to.pushNamed("/sign_up/", arguments: user);

  void onTapSignUp() => Modular.to.pushNamed("/sign_up/");

  void onTapShowPassword() => update(state.copyWith(hasShowPassoword: !state.hasShowPassoword));

  void onTapInLogin() => Modular.to.pushNamed("/core/client/");
}
