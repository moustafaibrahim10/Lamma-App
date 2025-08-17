import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool obscure = true;
  Widget suffixIcon = Icon(Icons.visibility_off);

  void changePasswordMode() {
    obscure = !obscure;
    suffixIcon = obscure ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    emit(ChangePasswordModeState());
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(LoginSuccessState(value.user!.uid));
        })
        .catchError((error) {
          print(error);
          emit(LoginErrorState(error.toString()));
        });
  }
}
