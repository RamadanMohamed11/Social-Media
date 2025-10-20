import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/helper/show_dialog.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/email_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/logo.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/password_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/register_now_widget.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/widget_0616.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoginSuccess) {
            if (userModel != null) {
              GoRouter.of(
                context,
              ).pushReplacement(AppRouter.kLayoutView, extra: userModel);
              BlocProvider.of<AuthenticationCubit>(context).emitInitial();
            }
          } else if (state is AuthenticationSignUpSuccess) {
            showMessageDialog(
              context,
              true,
              false,
              "User created successfully",
              btnOkOnPress: () {
                BlocProvider.of<AuthenticationCubit>(context).emitInitial();
              },
            );
            BlocProvider.of<AuthenticationCubit>(context).emitInitial();
          } else if (state is AuthenticationSignOutSuccess) {
            showMessageDialog(
              context,
              false,
              true,
              "User signed out successfully",
              btnOkOnPress: () {
                BlocProvider.of<AuthenticationCubit>(context).emitInitial();
              },
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInitial ||
              state is AuthenticationSignUpSuccess ||
              state is AuthenticationSignOutSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Logo(),
                          Gap(20),
                          Widget0616(),
                          Gap(20),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(fontSize: 24),
                          ),
                          Gap(30),
                          EmailTextFormField(
                            controller: emailController,
                            onSaved: emailOnSavedMethod,
                          ),
                          Gap(20),
                          PasswordTextFormField(
                            controller: passwordController,
                            onSaved: passwordOnSavedMethod,
                          ),
                          Gap(30),
                          CustomButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                userModel =
                                    await BlocProvider.of<AuthenticationCubit>(
                                      context,
                                    ).signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            },
                            text: 'login',
                          ),
                          Gap(30),
                          RegisterNowWidget(isLogin: true),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is AuthenticationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthenticationFailure) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }

  void emailOnSavedMethod(String? value) {
    emailController.text = value ?? '';
  }

  void passwordOnSavedMethod(String? value) {
    passwordController.text = value ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
