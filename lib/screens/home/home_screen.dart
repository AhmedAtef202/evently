import 'package:evently_app/screens/add_event/add_event_screen.dart';
import 'package:evently_app/screens/home/taps/events_tap.dart';
import 'package:evently_app/screens/home/taps/fav_tab.dart';
import 'package:evently_app/screens/home/taps/map_tap.dart';
import 'package:evently_app/screens/home/taps/profile_tab.dart';
import 'package:evently_app/screens/register/login_screen.dart';
import 'package:evently_app/theme/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedCategoryindex = 0;
  List<String> categories = [
    "All",
    "sport",
    "meeting",
    "holiday",
    "exhibition",
    "gaming",
    "workshop",
    "eating",
    "bookclub",
    "birthday",
  ];

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                userProvider.clearData();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (_) => false);
              },
              icon: Icon(Icons.logout_outlined, color: Colors.white))
        ],
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome To Evently ✨",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
            ),
            Row(
              children: [
                Text(
                  userProvider.userdata?.name ?? "null",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  "Cairo , Egypt",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryindex = index;
                      });
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedCategoryindex == index
                              ? Colors.white
                              : AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Text(categories[index],
                            style: TextStyle(
                              color: selectedCategoryindex == index
                                  ? AppColor.primaryColor
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ))),
                  );
                },
                itemCount: categories.length,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEventScreen.routeName);
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
        mini: true,
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 3,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        color: AppColor.primaryColor,
        child: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(color: Colors.white),
            selectedLabelStyle: GoogleFonts.inter(
              color: Colors.white,
            ),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                activeIcon: Icon(Icons.location_on),
                label: "Map",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                activeIcon: Icon(Icons.favorite),
                label: "Favourite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
      ),
      body: [
        EventsTap(
          category: categories[selectedCategoryindex],
        ),
        MapTap(),
        FavTab(),
        ProfileTab(),
      ][selectedIndex],
    );
  }

  List<Widget> taps = [];
}
