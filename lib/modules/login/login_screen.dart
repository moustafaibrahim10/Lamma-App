import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/local/cache_helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_images.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/register_screen.dart';

import '../../core/shared/components/components.dart';
import '../../core/utils/enums.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(msg: state.error, state: ToastState.error);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId);
            pushAndFinish(context: context, screen: SocialLayout());
            showToast(
              msg: "Login done successfully",
              state: ToastState.success,
            );
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar( ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.75,
                          image: AssetImage(AppImages.logo),
                        ),
                      ),
                      Text(
                        AppStrings.login,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        AppStrings.loginNow,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 15),
                      defaultTextFormField(
                        controller: emailController,
                        icon: Icons.email,
                        labelText: "Email",
                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter your email";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      defaultTextFormField(
                        controller: passwordController,
                        icon: Icons.lock,
                        labelText: "Password",
                        obscureText: cubit.obscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePasswordMode();
                          },
                          icon: cubit.suffixIcon,
                        ),
                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter your Password";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder:
                              (context) => Center(
                                child: defaultElevatedButton(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:  double.infinity,

                                  context: context,
                                  text: "Login",
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                ),
                              ),
                          fallback:
                              (context) =>
                                  Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      //SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
