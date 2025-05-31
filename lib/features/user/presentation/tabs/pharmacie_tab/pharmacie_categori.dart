import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/controller/pharmacy_cubit.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/data/repos/pharmacy_implementation_repo.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/pharmaci_list_view.dart';
import 'package:graduation_project/shared_widgets/LocationDisplayWidget.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_filter.dart';
import 'package:graduation_project/shared_widgets/navegaitor_row.dart';

import '../../../../../core/utils/app_colors.dart';

class PharmacieCategori extends StatelessWidget {
  const PharmacieCategori({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Responsive padding
    final double horizontalPadding = screenWidth * 0.02; // for 6.w / 8.w
    final double topPadding = screenHeight * 0.03;    // for 25.h

    // Responsive SizedBox heights
    final double sBoxHeight10 = screenHeight * 0.012; // for 10.h
    final double sBoxHeight15 = screenHeight * 0.018; // for 15.h
    final double sBoxHeight8 = screenHeight * 0.01;   // for 8.h

    // Responsive Text sizes
    final double titleFontSize = (30 * (screenWidth / 412)).clamp(22.0, 36.0) * textScaleFactor;

    return BlocProvider(
      create: (context) =>
          PharmacyCubit(pharmacyRepo: PharmacyRepoImplementationFromApi())
            ..fetchPharmacies(),
      child: Padding(
        padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, top: topPadding),
        child: ListView(
          children: [
            const Row( // Assuming LocationDisplayWidget handles its own responsiveness
              children: [
                Expanded(child: LocationDisplayWidget()),
                // Spacer(), // Might not be needed
              ],
            ),
             SizedBox(
              height: sBoxHeight10,
            ),
            Text(
              "Pharmacies",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall // Using a theme style and then overriding size
                  ?.copyWith(fontSize: titleFontSize, fontWeight: FontWeight.bold),
            ),
             SizedBox(
              height: sBoxHeight15,
            ),
            const Row( // Assuming ContainerSearch and CustomIconFilter handle their own responsiveness
              children: [
                Expanded(child: ContainerSearch()),
                SizedBox(width: 8), // Added spacing
                CustomIconFilter(),
              ],
            ),
             SizedBox(
              height: sBoxHeight8,
            ),
            const NavegaitorRow(), // Assuming this handles its own responsiveness
            const PharmaciesSection(numToShow: 100)
          ],
        ),
      ),
    );
  }
}

class PharmaciesSection extends StatelessWidget {
  final int startIndex;
  final int numToShow;

  const PharmaciesSection({super.key, this.startIndex = 0, this.numToShow = 2});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Responsive sizes for error/empty states
    final double errorIconSize = (48 * (screenWidth / 412)).clamp(35.0, 60.0);
    final double sBoxHeight16 = screenHeight * 0.02; // for 16.h
    final double messageFontSize = (14 * (screenWidth / 412)).clamp(11.0, 18.0) * textScaleFactor;
    final double emptyStateFontSize = (16 * (screenWidth / 412)).clamp(12.0, 20.0) * textScaleFactor;


    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        if (state is PharmacyLoading) {
          return  Center(child: CircularProgressIndicator(
            color: AppColors.blue,
          ));
        } else if (state is PharmacyError) {
          return Center(
            child: Padding( // Added padding for error state
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: errorIconSize),
                  SizedBox(height: sBoxHeight16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: messageFontSize),
                  ),
                  SizedBox(height: sBoxHeight16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PharmacyCubit>().fetchPharmacies();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
                      textStyle: TextStyle(fontSize: messageFontSize * 0.9)
                    ),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        } else if (state is PharmacyLoaded) {
          if (state.pharmacies.isEmpty) {
            return Center(
              child: Padding( // Added padding for empty state
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Text(
                  'No pharmacies available',
                  style: TextStyle(fontSize: emptyStateFontSize),
                ),
              ),
            );
          }
          final pharmaciesToShow = state.pharmacies.skip(startIndex).take(numToShow).toList();
          // Assuming PharmaciListView handles its own internal responsiveness
          return PharmaciListView(pharmacyy: pharmaciesToShow);
        } else {
          return Center(
            child: Padding( // Added padding for no data state
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Text(
                'No data available',
                style: TextStyle(fontSize: emptyStateFontSize),
              ),
            ),
          );
        }
      },
    );
  }
}
