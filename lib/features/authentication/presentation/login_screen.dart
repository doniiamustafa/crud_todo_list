import 'package:crud_local_testing_app/config/app_strings.dart';
import 'package:crud_local_testing_app/core/dependency_injection.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';
import 'package:crud_local_testing_app/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:crud_local_testing_app/features/authentication/presentation/controller/login_controller.dart';
import 'package:crud_local_testing_app/features/authentication/presentation/widgets/app_gradient_button.dart';
import 'package:crud_local_testing_app/features/authentication/presentation/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final LoginUsecase loginUseCase = instance<LoginUsecase>();

  late final LoginController loginController;

  @override
  void initState() {
    super.initState();
    loginController = LoginController(
      loginUseCase: loginUseCase,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    AppStrings.login,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.745,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 22.0),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 16.0, color: Colors.grey)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                  child: Column(
                    children: [
                      AppTextFormField(
                          title: AppStrings.email,
                          hint: AppStrings.enteryourEmail,
                          controller: _emailTextEditingController),
                      AppTextFormField(
                          title: AppStrings.password,
                          hint: AppStrings.enterPassword,
                          controller: _passwordTextEditingController),
                      AppGradientButton(
                        title: AppStrings.signIn,
                        height: MediaQuery.of(context).size.height * 0.065,
                        width: double.infinity,
                        onPressed: () {
                          loginController.login(
                              _emailTextEditingController.text,
                              _passwordTextEditingController.text);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
