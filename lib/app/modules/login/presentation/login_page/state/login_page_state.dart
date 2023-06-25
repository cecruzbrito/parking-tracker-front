class LoginPageState {
  static LoginPageState initialState = LoginPageState(hasShowPassoword: false);

  bool hasShowPassoword;

  LoginPageState({required this.hasShowPassoword});

  LoginPageState copyWith({
    bool? hasShowPassoword,
  }) {
    return LoginPageState(
      hasShowPassoword: hasShowPassoword ?? this.hasShowPassoword,
    );
  }
}
