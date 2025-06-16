import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/Drugs/drug_view_grid.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/Drugs/drug_view_horizontal.dart';
import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';

import '../../../../../../../core/utils/app_colors.dart';

class DrugView extends StatelessWidget {
  const DrugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
        ),
        centerTitle: true,
        title: Text(
          'Drugs',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 30.sp,
                color: AppColors.grey,
              ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          // Search Row
          SliverToBoxAdapter(
            child: Row(
              children: const [
                Expanded(child: ContainerSearch()),
                CustomIconCamera(),
              ],
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          // Image Carousel
          SliverToBoxAdapter(child: ImageCarouselWithCustomIndicator()),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          // Frequently Purchased Title
          SliverToBoxAdapter(
            child: Row(
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
                      .copyWith(fontSize: 20.sp),
                ),
              ],
            ),
          ),

          // Horizontal list
          SliverToBoxAdapter(child: DrugViewHorizontal()),

          // All Medicines Title
          SliverToBoxAdapter(
            child: Row(
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
                      .copyWith(fontSize: 20.sp),
                ),
              ],
            ),
          ),

          // DrugViewGrid داخل SizedBox بارتفاع كافي
          SliverToBoxAdapter(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height * 1.2, // زود لو بتحمل كثير
              child: const DrugViewGrid(),
            ),
          ),
        ],
      ),
    );
  }
}
