import 'package:flutter/material.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/forget_password_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _signUpInProgress = false;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailTextCtrl = TextEditingController();
  final TextEditingController _passwordTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return MaterialApp(
      home: Scaffold(
        body: BodyBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _loginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Get Started With",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        controller: _emailTextCtrl,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Email can't be empty";
                          }

                          if (!RegExp(r'\S+@\S+\.\S+')
                              .hasMatch(value.toString())) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordTextCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Please insert your pasword";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: !_signUpInProgress,
                          replacement: const CircularProgressIndicator(),
                          child: ElevatedButton(
                              onPressed: _singIn,
                              child: const Icon(
                                  Icons.arrow_circle_right_outlined)),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen()));
                            },
                            child: const Text(
                              "Forget Password?",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have a account?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              },
                              child: const Text(
                                "Sign Up",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _singIn() async {
    if (!_loginKey.currentState!.validate()) {
      return;
    }
    _signUpInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().postRrequest(Urls.login, body: {
      "email": _emailTextCtrl.text.trim(),
      "password": _passwordTextCtrl.text,
    });
    _signUpInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (!response.isSuccess) {
      clearTextField();
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(
              context, "Wrong Crendential!Please check email/password.");
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, "Something went wrong while login! Please try again.");
        }
      }
    } else {
      await AuthController.saveUserInfo(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));

      if (mounted) {
        showSnackMessage(
            context, "Login success! Redirect to dashboard.", true);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavScreen()));
      }
    }
  }

  void clearTextField() {
    _emailTextCtrl.clear();
    _passwordTextCtrl.clear();
  }

  @override
  void dispose() {
    _emailTextCtrl.dispose();
    _passwordTextCtrl.dispose();
    super.dispose();
  }
}
