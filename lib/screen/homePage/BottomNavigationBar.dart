import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:file_templeate/screen/sponsor/HomePageSponsor.dart';
import 'package:file_templeate/screen/homePage/show/showServicePlanner.dart';
import 'package:file_templeate/screen/homePage/show/showPackagPlanner.dart';
import 'package:file_templeate/screen/homePage/show/showorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'show/Favorite.dart';
import 'homepage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final screens = [
    HomePageSponsor(),
    ShowOrder(),
    Favorite(),
    HomePageService(),
    HomePagePackage(),
  ];

  final _pageController = PageController(initialPage: 4);
  int maxCount = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(screens.length, (index) => screens[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (screens.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showLabel: true,
              notchColor: Color(0xFFedbe38),

        bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.people,
                    color: Color(0xFF004079),
                  ),
                  activeItem: Icon(
                    Icons.people,
                    color: Color.fromARGB(255, 244, 244, 245),
                  ),
                  itemLabel: 'الرعاة',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.shopping_basket,
                    color: Color(0xFF004079),
                  ),
                  activeItem: Icon(
                    Icons.shopping_basket,
                    color: Color.fromARGB(255, 244, 244, 245),
                  ),
                  itemLabel: 'اختياراتك',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.favorite,
                    color: Color(0xFF004079),
                  ),
                  activeItem: Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 244, 244, 245),
                  ),
                  itemLabel: 'المفضلة',
                ),
                BottomBarItem(
                  inActiveItem: ImageIcon(
                    AssetImage("images/store.png"),
                    color: Color(0xFF004079),
                    size: 24,
                  ),

                  activeItem: ImageIcon(
                    AssetImage("images/store.png"),
                    color: Colors.white,
                    size: 24,
                  ),
                  itemLabel: 'الخدمات',
                ),
                BottomBarItem(
                  // inActiveItem: Icon(
                  //   Icons.home,
                  //   color: Color(0xFF004079),
                  // ),

                  // activeItem: Icon(
                  //   Icons.home_filled,
                  //   color: Colors.white,
                  // ),
                  inActiveItem: ImageIcon(
                    AssetImage("images/box.png"),
                    color: Color(0xFF004079),
                    size: 24,
                  ),



                  activeItem: ImageIcon(
                    AssetImage("images/box.png"),
                    color: Colors.white,
                    size: 24,
                  ),

                  itemLabel: 'الباقات',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
