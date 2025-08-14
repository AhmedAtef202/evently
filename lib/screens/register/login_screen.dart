import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:evently_app/firebase/firebasemanger.dart';
import 'package:evently_app/screens/home/home_screen.dart';
import 'package:evently_app/screens/register/signup_screen.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Image.asset(
                  "assets/images/Logo .png",
                  width: 136,
                  height: 186,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }

                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: GoogleFonts.inter(
                        textStyle: theme.textTheme.bodyMedium),
                    prefixIcon: Icon(
                      Icons.email,
                      color: theme.iconTheme.color,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }

                    return null;
                  },
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Passsword",
                    hintStyle: GoogleFonts.inter(
                        textStyle: theme.textTheme.bodyMedium),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: theme.iconTheme.color,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text("Forget Password?",
                      style: GoogleFonts.inter(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primaryColor,
                      )),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (!formkey.currentState!.validate()) return;

                      await Firebasemanger.Login(
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          userProvider.initUser();
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false);
                        },
                        onError: (message) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: message,
                            descTextStyle: GoogleFonts.inter(
                              textStyle: theme.textTheme.bodyMedium!.copyWith(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();
                        },
                      );
                    },
                    child: Text("Login",
                        style: GoogleFonts.inter(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    )),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text.rich(TextSpan(
                      text: "Don't Have Account ? ",
                      style: GoogleFonts.inter(
                          textStyle: theme.textTheme.bodyMedium),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                context, SignupScreen.routeName),
                          text: "Create Account",
                          style: GoogleFonts.inter(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ])),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColor.primaryColor,
                          endIndent: 20,
                        ),
                      ),
                      Center(
                          child: Text(
                        "OR",
                        style: GoogleFonts.inter(
                            color: AppColor.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                      const Expanded(
                        child: Divider(
                          indent: 20,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(child: Text("Login With")),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Firebasemanger.signInWithGoogle();
                        userProvider.initUser();

                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (_) => false);
                      },
                      child: Image.asset(
                        "assets/images/google.png",
                        width: 50,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
