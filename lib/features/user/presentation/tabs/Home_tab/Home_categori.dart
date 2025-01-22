// ignore_for_file: deprecated_member_use

import 'package:graduation_project/features/user/presentation/tabs/Home_tab/hom_widget.dart/Category_view.dart';
import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:graduation_project/shared_widgets/LocationDisplayWidget.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';
import 'package:flutter/material.dart';

import '../../../../../shared_widgets/container_search.dart';
import '../../pharmacy_list/pharmacy_list.dart';
import '../../../../../shared_widgets/navegaitor_row.dart';

class HomeCategori extends StatefulWidget {
  const HomeCategori({super.key});

  @override
  State<HomeCategori> createState() => _HomeCategoriState();
}

class _HomeCategoriState extends State<HomeCategori> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(child: LocationDisplayWidget()),
                Spacer(),
                ImageIcon(
                  AssetImage(
                    'assets/images/Cart Icon.png',
                  ),
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Expanded(child: ContainerSearch()),
                CustomIconCamera(),
              ],
            ),
            ImageCarouselWithCustomIndicator(),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(Icons.grid_view),
                Text(
                  "Category",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const CategoryView(),
            const SizedBox(
              height: 40,
            ),
            const NavegaitorRow(),
            const SizedBox(
              height: 10,
            ),
            const PharmacyList(),
          ],
        ),
      ),
    );
  }
}
