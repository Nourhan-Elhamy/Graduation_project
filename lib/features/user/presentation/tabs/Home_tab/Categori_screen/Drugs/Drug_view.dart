// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/Drugs/drug_view_grid.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/Drugs/drug_view_horizontal.dart';
import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';

class DrugView extends StatelessWidget {
  const DrugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Drugs',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 30,
              ),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Expanded(child: ContainerSearch()),
                CustomIconCamera(),
              ],
            ),
            const ImageCarouselWithCustomIndicator(),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                IconButton(
                  color: const Color(0xFF455A64),
                  icon: Icon(MdiIcons.pill),
                  onPressed: () {},
                ),
                Text(
                  "Frequently Purchased",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const DrugViewHorizontal(),
            Row(
              children: [
                IconButton(
                  color: const Color(0xFF455A64),
                  icon: Icon(MdiIcons.pill),
                  onPressed: () {},
                ),
                Text(
                  "All Medicines",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const DrugViewGrid(),
          ],
        ),
      ),
    );
  }
}
