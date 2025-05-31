import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/chat_bot/chat_bot.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Home_categori.dart';
import 'package:graduation_project/features/user/presentation/tabs/cart/presentation/views/cart_screen.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacie_categori.dart';
import 'package:graduation_project/features/user/presentation/tabs/profile_tab/profile_categori.dart';
import 'package:graduation_project/features/user/presentation/tabs/wish_tab/wish_categori.dart';

class HomeGround extends StatefulWidget {
  const HomeGround({super.key});

  @override
  State<HomeGround> createState() => _HomeGroundState();
}

List<Widget> tabs = [
  const HomeCategori(),
  const PharmacieCategori(),
  const WishCategori(),
  const CartScreen(),
  const ProfileCategori(),
];

int selectedTap = 0;

class _HomeGroundState extends State<HomeGround> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Responsive FAB size
    final double fabSize = (screenWidth * 0.15).clamp(50.0, 70.0);

    // Responsive BottomNavigationBar icon size
    final double navBarIconSize = (screenWidth * 0.06).clamp(22.0, 30.0);

    // Responsive BottomNavigationBar label font size
    final double navBarLabelFontSize = (12 * (screenWidth / 412)).clamp(10.0, 14.0) * textScaleFactor;


    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ChatBot()),
          );
        },
        child: SizedBox( // Constrain the FAB image size
          width: fabSize,
          height: fabSize,
          child: Image.asset(
            'assets/images/3x/chatpot.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: tabs[selectedTap],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed, // Ensures labels are always visible
        selectedItemColor: AppColors.blue, // Or your primary color
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: navBarLabelFontSize,
        unselectedFontSize: navBarLabelFontSize * 0.9, // Slightly smaller for unselected
        currentIndex: selectedTap,
        onTap: (index) {
          selectedTap = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/home_24px.png"),
              size: navBarIconSize,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/Pharmacy_Icon.png"),
              size: navBarIconSize,
            ),
            label: "Pharmacies",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/favorite_24px.png"),
              size: navBarIconSize,
            ),
            label: "Wish List",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage(
                'assets/images/Cart Icon.png',
              ),
              size: navBarIconSize,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/Profile Icon.png"),
              size: navBarIconSize,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
