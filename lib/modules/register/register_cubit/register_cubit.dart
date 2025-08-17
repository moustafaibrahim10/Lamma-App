import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obscure = true;
  Widget suffixIcon = Icon(Icons.visibility_off);
  bool obscureConfirm = true;
  Widget suffixIconConfirm = Icon(Icons.visibility_off);

  void changePasswordMode() {
    obscure = !obscure;
    suffixIcon = obscure ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    emit(ChangePasswordModeState());
  }

  void changePasswordModeConfirm() {
    obscureConfirm = !obscureConfirm;
    suffixIconConfirm =
    obscureConfirm ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    emit(ChangePasswordModeState());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uId: value.user!.uid,
      );
      print(value.user?.email);
      print(value.user?.uid);
    })
        .catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String uId,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
        uId: uId,
        image: "https://i.pinimg.com/736x/0a/2f/68/0a2f68448ab64c7fb67e75ef410de163.jpg",
        cover: "https://i.pinimg.com/736x/87/81/81/8781819f67f326f165d8bbdbf4cdbbe6.jpg",
        bio: "Write your bio...",
        isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
