import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/email_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/logo.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/name_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/password_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/register_now_widget.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/username_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/widget_0616.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSignUpSuccess) {
            BlocProvider.of<AuthenticationCubit>(context).emitInitial();
            GoRouter.of(context).pop();
          } else if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Logo(),
                    const Gap(20),
                    const Widget0616(),
                    const Gap(30),
                    NameTextFormField(
                      controller: nameController,
                      onSaved: nameOnSavedMethod,
                    ),
                    const Gap(20),
                    UsernameTextFormField(
                      controller: usernameController,
                      onSaved: usernameOnSavedMethod,
                    ),
                    const Gap(20),
                    EmailTextFormField(
                      controller: emailController,
                      onSaved: emailOnSavedMethod,
                    ),
                    const Gap(20),
                    PasswordTextFormField(
                      controller: passwordController,
                      onSaved: passwordOnSavedMethod,
                    ),
                    const Gap(30),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenticationCubit>(context).signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            username: usernameController.text,
                          );
                        }
                      },
                      text: 'Register',
                    ),
                    const Gap(30),
                    const RegisterNowWidget(isLogin: false),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void nameOnSavedMethod(String? value) {
    nameController.text = value ?? '';
  }

  void usernameOnSavedMethod(String? value) {
    usernameController.text = value ?? '';
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
