import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/care/care_view_grid.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/care/care_view_horizontal.dart';
import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';

import '../../../../../../../core/utils/app_colors.dart';

class CareView extends StatelessWidget {
  const CareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
            ),
            centerTitle: true,
            title: Text(
              'Personal Care',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 30.sp,
                    color: AppColors.grey,
                  ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Expanded(child: ContainerSearch()),
                  SizedBox(width: 5.w),
                  CustomIconCamera(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          const SliverToBoxAdapter(child: ImageCarouselWithCustomIndicator()),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Icon(Icons.volunteer_activism, color: AppColors.blue),
                  SizedBox(width: 5.w),
                  Text(
                    "Best Seller",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: CareViewHorizontal()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Icon(Icons.favorite_border, color: AppColors.blue),
                  SizedBox(width: 5.w),
                  Text(
                    "All Products",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
          ),
          CareViewGrid(),
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }
}
