import 'package:estacionamento_rotativo/app/modules/login/presentation/login_page/state/login_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../shared/presentation/widgets/app_bar_default.dart';
import '../../../../../shared/presentation/widgets/button_app.dart';
import '../../../../../shared/presentation/widgets/field_app.dart';
import '../../../../../shared/presentation/widgets/scaffold_app.dart';
import '../store/login_page_store.dart';
import 'widgets/button_sign_up.dart';
import 'widgets/google_button_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.store});
  final LoginPageStore store;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageStore get store => widget.store;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TripleBuilder<LoginPageStore, LoginPageState>(
        store: store,
        builder: (__, trp) {
          return ScaffoldApp(
              isLoading: store.isLoading,
              settingsAppBar: AppBarDefault(settings: AppBarSettings()),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Faça o seu login", style: TextStyle(fontSize: size.height * .05)),
                        SizedBox(height: size.height * .04),
                        FieldApp(
                          settings: SettingsFieldApp(ctr: store.ctrEmail, prefixIcon: Icons.email, labelText: "Email"),
                        ),
                        SizedBox(height: size.height * .02),
                        FieldApp(
                          settings: SettingsFieldApp(
                              labelText: "Senha",
                              ctr: store.ctrPassword,
                              prefixIcon: Icons.lock,
                              hasShowText: trp.state.hasShowPassoword,
                              suffixIcon: SufixIconFieldApp(
                                  icon: trp.state.hasShowPassoword ? Icons.visibility_off : Icons.visibility,
                                  onTap: store.onTapShowPassword)),
                        ),
                        SizedBox(height: size.height * .02),
                        SizedBox(width: double.infinity, child: ButtonApp(label: "Login", onTap: store.onTapInLogin)),
                        SizedBox(height: size.height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(child: Divider()),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: size.width * .02),
                                child: const Text("ou continue com",
                                    style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)))),
                            const Expanded(child: Divider())
                          ],
                        ),
                        SizedBox(height: size.height * .03),
                        GoogleButtonSignIn(onTap: store.onTapInSignUpGoogle),
                        SizedBox(height: size.height * .05),
                        ButtonSignUp(onTap: store.onTapSignUp)
                      ]),
                ),
              ));
        });
  }
}
