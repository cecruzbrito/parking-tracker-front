import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../domain/entity/user_credential_entity.dart';
import '../../../domain/usecases/login/login_api_usecase_imp.dart';
import '../../../domain/usecases/social_login/social_auth_usecase_google_auth_imp.dart';
import '../state/login_page_state.dart';

class LoginPageStore extends Store<LoginPageState> {
  LoginPageStore(this._socialAuthGoogle, this._loginApi) : super(LoginPageState.initialState);

  final SocialAuthUsecaseGoogleAuthImp _socialAuthGoogle;
  final LoginApiUsecaseAuthImp _loginApi;

  final ctrEmail = TextEditingController();

  final ctrPassword = TextEditingController();

  final formsKey = GlobalKey<FormState>();

  Future<void> onTapInSignUpGoogle() async {
    setLoading(true);
    final response = await _socialAuthGoogle();
    setLoading(false);
    response.fold((l) => null, _signUp);
  }

  void _signUp(UserCredentialEntity? user) => Modular.to.pushNamed("/sign_up/", arguments: user);

  void onTapSignUp() => Modular.to.pushNamed("/sign_up/");

  void onTapShowPassword() => update(state.copyWith(hasShowPassoword: !state.hasShowPassoword));

  Future<void> onTapInLogin() async {
    if (!formsKey.currentState!.validate()) return;
    setLoading(true);
    final response = await _loginApi(email: ctrEmail.text, password: ctrPassword.text);
    setLoading(false);
    response.fold((l) => setError(l, force: true), _goToHome);
  }

  _goToHome(UserEntity user) =>
      user.type == TypeOfUser.client ? Modular.to.pushNamed("/core/client/") : Modular.to.pushNamed("/core/agent/");
}
