import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/core/shared/local/cache_helper.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/register_cubit/register_cubit.dart';
import 'package:social_app/modules/register/register_cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showToast(msg: state.error, state: ToastState.error);
          }
          if (state is RegisterSuccessState) {
            showToast(msg: "Register Successfully", state: ToastState.success);
          }
          if (state is CreateSuccessState) {
            pushAndFinish(context: context, screen: SocialLayout());
            CacheHelper.saveData(key: "uId", value: state.uId);
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                "Create an account",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "If you don't have an account, please register now",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 10),
                      defaultTextFormField(
                        controller: nameController,
                        labelText: "Name",
                        icon: Icons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please Enter Your Name";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      defaultTextFormField(
                        controller: emailController,
                        labelText: "email",
                        icon: Icons.email,
                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please Enter Your Email";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      defaultTextFormField(
                        controller: phoneController,
                        labelText: "Phone",
                        icon: Icons.phone,
                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please Enter Your phone";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      defaultTextFormField(
                        controller: passwordController,
                        labelText: "Password",
                        icon: Icons.lock,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePasswordMode();
                          },
                          icon: cubit.suffixIcon,
                        ),
                        obscureText: cubit.obscure,

                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please Enter Your password";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      defaultTextFormField(
                        controller: confirmPasswordController,
                        labelText: "Confirm Password",
                        icon: Icons.lock,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePasswordModeConfirm();
                          },
                          icon: cubit.suffixIconConfirm,
                        ),
                        obscureText: cubit.obscureConfirm,
                        validate: (value) {
                          if (value == null || value.isEmpty)
                            return "Please Enter your confirm Password";
                          if (passwordController.text !=
                              confirmPasswordController.text)
                            return "Confirm Password doesn't match password";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder:
                              (context) => Center(
                                child: defaultElevatedButton(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width:  double.infinity,
                                  context: context,
                                  text: "Register",
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
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
