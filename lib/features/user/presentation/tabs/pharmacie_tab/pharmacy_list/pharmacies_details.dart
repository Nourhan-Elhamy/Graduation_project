// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/utils/app_colors.dart';
import 'controller/pharmacy_details_cubit.dart';
import 'controller/productpharmacy-horizontal.dart';
import 'data/repos/pharmacy_implementation_repo.dart';
class PharmaciesDetails extends StatefulWidget {
  final String pharmacyId;

  const PharmaciesDetails({super.key, required this.pharmacyId});

  @override
  _PharmaciesDetailsState createState() => _PharmaciesDetailsState();
}

class _PharmaciesDetailsState extends State<PharmaciesDetails> {
  String selectedCategory = 'All'; // الفئة المختارة

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => PharmacyDetailsCubit(
          pharmacyRepo: PharmacyRepoImplementationFromApi())
        ..getPharmacyDetails(widget.pharmacyId),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
            builder: (context, state) {
              if (state is PharmacyDetailsLoading) {
                return const Center(child: CircularProgressIndicator());

              } else if (state is PharmacyDetailsError) {

                return Center(child: Text(state.message));

              } else if (state is PharmacyDetailsLoaded) {

                final pharmacy = state.pharmacy;

                // تحديد المنتجات بناءً على الفئة المختارة
                List<dynamic> filteredProducts;
                if (selectedCategory == 'Drugs') {

                } else if (selectedCategory == 'Personal Care') {

                } else {

                }

                return Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(pharmacy.image,
                            width: double.infinity, fit: BoxFit.cover),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:
                          Icon(Icons.arrow_back_ios, color: AppColors.blue),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      children: [
                        Text(
                          pharmacy.name,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith( fontSize: 30),
                        ),

                        Text(
                          pharmacy.description,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Address:${pharmacy.address}",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),

                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Phone:+${pharmacy.phone}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors
                                    .iconColor, // لتقليل الشفافية إلى 50%

                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: AppColors.blue),
                                  Text("1.3 KM",
                                      style: TextStyle(color: AppColors.blue)),
                                ],
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.2),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.blue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amberAccent),
                                  Text("3.5 (200 Review)",
                                      style: TextStyle(color: AppColors.blue)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const ContainerSearch(),
                              SizedBox(width: screenWidth * 0.05),
                              const CustomIconCamera(),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            FilterButton(
                              label: "All",
                              isSelected: selectedCategory == 'All',
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                  'All'; // تغيير الفئة المختارة
                                });
                              },
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            FilterButton(
                              label: "Personal Care",
                              isSelected: selectedCategory == 'Personal Care',
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                  'Personal Care'; // تغيير الفئة المختارة
                                });
                              },
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            FilterButton(
                              label: "Drugs",
                              isSelected: selectedCategory == 'Drugs',
                              onTap: () {
                                setState(() {
                                  selectedCategory =
                                  'Drugs'; // تغيير الفئة المختارة
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
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
                        SizedBox(height: screenHeight * 0.01),
                        // عرض المنتجات المفلترة
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton(
      {super.key,
        required this.label,
        required this.isSelected,
        required this.onTap});
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap, // عند الضغط يتم استدعاء الدالة onTap
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blue : AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.blue,
          ),
        ),
      ),
    );
  }
}
