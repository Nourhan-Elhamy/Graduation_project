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
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,color: AppColors.blue,)),
        centerTitle: true,
        title: Text(
          'Personal Care',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 30.sp,
              color: AppColors.grey
          ),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(
              height: 15.h,
            ),
             Row(
              children: [
                Expanded(child: ContainerSearch()),
                SizedBox(
                 width:5.w,
                ),
                CustomIconCamera(),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            const ImageCarouselWithCustomIndicator(),
             SizedBox(
              height: 15.h,
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
                      .copyWith(fontSize: 20.sp),
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
                      .copyWith(fontSize: 20.sp),
                ),
              ],
            ),
            CareViewGrid(),
          ],
        ),
      ),
    );
  }
}
