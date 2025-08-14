import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/screens/register/login_screen.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:google_fonts/google_fonts.dart';

class IntroductionScreens extends StatefulWidget {
  static const String routeName = 'Intro';

  const IntroductionScreens({super.key});

  @override
  State<IntroductionScreens> createState() => _IntroductionScreensState();
}

class _IntroductionScreensState extends State<IntroductionScreens> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: isDarkTheme
          ? AppColor.darkbackgroundColor
          : AppColor.lightbackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo2.png",
                width: 170,
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/onbording.png",
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              Text("introduction_title".tr(),
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDarkTheme ? Colors.white : AppColor.primaryColor,
                  )),
              const SizedBox(height: 20),
              Text("introduction_sub_title".tr(),
                  style: GoogleFonts.inter(
                      textStyle: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDarkTheme ? Colors.white70 : Colors.black87,
                  ))),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: Text("language".tr(),
                        style: GoogleFonts.inter(
                            textStyle: theme.textTheme.bodyLarge!.copyWith(
                                color: isDarkTheme
                                    ? Colors.white
                                    : AppColor.primaryColor,
                                fontWeight: FontWeight.w500))),
                  ),
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: isDarkTheme
                                ? Colors.white
                                : AppColor.primaryColor,
                            width: 3),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.setLocale(const Locale('en'));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: isDarkTheme
                                        ? Colors.white
                                        : AppColor.primaryColor,
                                    width: 3,
                                    style: context.locale.toString() == "en"
                                        ? BorderStyle.solid
                                        : BorderStyle.none),
                              ),
                              child: Image.asset(
                                "assets/images/LR.png",
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              context.setLocale(const Locale('ar'));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: isDarkTheme
                                        ? Colors.white
                                        : AppColor.primaryColor,
                                    width: 3,
                                    style: context.locale.toString() == "ar"
                                        ? BorderStyle.solid
                                        : BorderStyle.none),
                              ),
                              child: Image.asset(
                                "assets/images/EG.png",
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text("theme".tr(),
                        style: GoogleFonts.inter(
                            textStyle: theme.textTheme.bodyLarge!.copyWith(
                                color: isDarkTheme
                                    ? Colors.white
                                    : AppColor.primaryColor,
                                fontWeight: FontWeight.w500))),
                  ),
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: isDarkTheme
                                ? Colors.white
                                : AppColor.primaryColor,
                            width: 3),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isDarkTheme = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColor.primaryColor,
                                  width: 3,
                                  style: isDarkTheme
                                      ? BorderStyle.none
                                      : BorderStyle.solid,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/Sun.png",
                                color: AppColor.primaryColor,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isDarkTheme = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColor.primaryColor,
                                  width: 3,
                                  style: isDarkTheme
                                      ? BorderStyle.solid
                                      : BorderStyle.none,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/Moon.png",
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text("intro_btn".tr(),
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
