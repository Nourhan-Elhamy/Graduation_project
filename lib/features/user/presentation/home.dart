import 'package:flutter/material.dart';
import 'package:graduation_project/features/user/presentation/chat_bot/chat_bot.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Home_categori.dart';
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
  const ProfileCategori(),
];

int selectedTap = 0;

class _HomeGroundState extends State<HomeGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ChatBot()),
          );
        },
        child: Image.asset('assets/images/Chat.png'),
      ),
      body: tabs[selectedTap],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTap,
        onTap: (index) {
          selectedTap = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/Home Container.png"),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/Pharmacy Icon.png"),
            ),
            label: "Pharmacies",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/favorite_24px.png"),
            ),
            label: "Wish List",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/Profile Icon.png"),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
