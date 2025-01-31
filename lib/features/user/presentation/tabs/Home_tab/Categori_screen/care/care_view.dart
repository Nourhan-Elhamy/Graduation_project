import 'package:flutter/material.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/care/care_view_grid.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/care/care_view_horizontal.dart';
import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';

class CareView extends StatelessWidget {
  const CareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Personal Care',
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
                  icon: const Icon(Icons.volunteer_activism),
                  onPressed: () {},
                ),
                Text(
                  "Best Seller",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const CareViewHorizontal(),
            Row(
              children: [
                IconButton(
                  color: const Color(0xFF455A64),
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                Text(
                  "All Products",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const CareViewGrid(),
          ],
        ),
      ),
    );
  }
}
