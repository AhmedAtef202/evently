import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:evently_app/firebase/firebasemanger.dart';
import 'package:evently_app/models/userdata.dart';
import 'package:evently_app/screens/home/home_screen.dart';
import 'package:evently_app/screens/register/login_screen.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'SignupScreen';

  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: GoogleFonts.inter(textStyle: theme.textTheme.bodyLarge),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: theme.textTheme.bodyLarge!.color,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                      return 'Name is required';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    label: const Text("Name"),
                    labelStyle: GoogleFonts.inter(
                        textStyle: theme.textTheme.bodyMedium),
                    prefixIcon: Icon(
                      Icons.person,
                      color: theme.iconTheme.color,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value.trim());

                    if (!emailValid) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Email"),
                    labelStyle: GoogleFonts.inter(
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is required';
                    }
                    if (value.length != 11) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Phone"),
                    labelStyle: GoogleFonts.inter(
                        textStyle: theme.textTheme.bodyMedium),
                    prefixIcon: Icon(
                      Icons.call,
                      color: theme.iconTheme.color,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  obscureText: !isPasswordVisible,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Password"),
                    labelStyle: GoogleFonts.inter(
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  obscureText: !isRePasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value != passwordController.text) {
                      return 'Password Not much';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Re Passsword"),
                    labelStyle: GoogleFonts.inter(
                        textStyle: theme.textTheme.bodyMedium),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: theme.iconTheme.color,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isRePasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isRePasswordVisible = !isRePasswordVisible;
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        Userdata user = Userdata(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          id: "",
                        );

                        await Firebasemanger.SignUp(
                          user: user,
                          password: passwordController.text,
                          onError: (value) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: value,
                              descTextStyle: GoogleFonts.inter(
                                textStyle: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            )..show();
                          },
                          onSuccess: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Success',
                              desc: "Account Created Successfully",
                              descTextStyle: GoogleFonts.inter(
                                textStyle: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              btnCancelOnPress: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                              btnOkOnPress: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                            )..show();
                          },
                        );
                      }
                    },
                    child: Text("Sign Up",
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
                      text: "Already Have Account ? ",
                      style: GoogleFonts.inter(
                          textStyle: theme.textTheme.bodyMedium),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                context, LoginScreen.routeName),
                          text: "Login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
