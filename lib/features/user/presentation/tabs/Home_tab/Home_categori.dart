// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_project/features/user/presentation/tabs/Home_tab/hom_widget.dart/Category_view.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/hom_widget.dart/article_category_View.dart';
import 'package:graduation_project/shared_widgets/Image%20Carousel.dart';
import 'package:graduation_project/shared_widgets/LocationDisplayWidget.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../shared_widgets/container_search.dart';
import '../../../../../shared_widgets/navegaitor_row.dart';

import '../pharmacie_tab/pharmacie_categori.dart';
import '../pharmacie_tab/pharmacy_list/controller/pharmacy_cubit.dart';
import '../pharmacie_tab/pharmacy_list/data/repos/pharmacy_implementation_repo.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart'; // Removed
import 'dart:math' as math;


class HomeCategori extends StatefulWidget {
  const HomeCategori({super.key});

  @override
  State<HomeCategori> createState() => _HomeCategoriState();
}

class _HomeCategoriState extends State<HomeCategori> {
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 25.h),
      child: BlocProvider(
        create: (context) =>
        PharmacyCubit(pharmacyRepo: PharmacyRepoImplementationFromApi())
          ..fetchPharmacies(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              const Row( // Assuming LocationDisplayWidget handles its own responsiveness
                children: [
                  Expanded(child: LocationDisplayWidget()),
                  // Spacer(), // Spacer might not be needed if LocationDisplayWidget expands
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row( // Assuming ContainerSearch and CustomIconCamera handle their own responsiveness
                children: [
                  Expanded(child: ContainerSearch()),
               SizedBox(width: 5.w,),
                  CustomIconCamera(),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              const ImageCarouselWithCustomIndicator(), // Assuming this is responsive
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Icon(Icons.grid_view_outlined, color: AppColors.grey,),

                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const CategoryView(), // Assuming this handles its own responsiveness
              SizedBox(
                height: 50.h,
              ),
              const NavegaitorRow(), // Assuming this handles its own responsiveness
              SizedBox(
                  height: 8.h,
              ),
              SizedBox( // Duplicate SizedBox removed
                 height: 8.h,
               ),
              const PharmaciesSection(startIndex: 1, numToShow: 2), // Assuming this handles its own responsiveness
              SizedBox(
                height: 29.h,
              ),
              Row(
                children: [
                  Icon(Icons.article,),

                  Text(
                    "Health Articles",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ArticleCategoryView(), // Assuming this handles its own responsiveness
            ],
          ),
        ),
      ),
    );
  }
}
