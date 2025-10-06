import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
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
                Gap(30),
                NameTextFormField(
                  controller: nameController,
                  onSaved: nameOnSavedMethod,
                ),
                Gap(20),
                UsernameTextFormField(
                  controller: usernameController,
                  onSaved: usernameOnSavedMethod,
                ),
                Gap(20),
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
                CustomButton(onPressed: () {}, text: 'Register'),
                Gap(30),
                RegisterNowWidget(isLogin: false),
              ],
            ),
          ),
        ),
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
