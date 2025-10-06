import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Logo(),
                Gap(20),
                Widget0616(),
                Gap(20),
                const Text('Welcome Back', style: TextStyle(fontSize: 24)),
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
                CustomButton(onPressed: () {}, text: 'login'),
                Gap(30),
                RegisterNowWidget(isLogin: true),
              ],
            ),
          ),
        ),
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
