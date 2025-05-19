// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../shared_widgets/LoadingIndecator.dart';
import '../../Home_tab/Categori_screen/Drugs/drug_view_horizontal.dart';
import '../../Home_tab/Categori_screen/care/care_view_horizontal.dart';
import 'controller/pharmacy_details_cubit.dart';

import 'data/repos/pharmacy_implementation_repo.dart';

class PharmaciesDetails extends StatefulWidget {
  final String pharmacyId;

  const PharmaciesDetails({super.key, required this.pharmacyId});

  @override
  _PharmaciesDetailsState createState() => _PharmaciesDetailsState();
}

class _PharmaciesDetailsState extends State<PharmaciesDetails> {
  String selectedCategory = 'Drugs'; // الفئة المختارة

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
                  // يمكن إضافة منطق عرض المنتجات الخاصة بالفئة "Drugs" هنا
                  DrugViewHorizontal(); // افترض أن "drugs" هي قائمة المنتجات الخاصة
                } else if (selectedCategory == 'Personal Care') {
                  // يمكن إضافة منطق عرض المنتجات الخاصة بالفئة "Personal Care" هنا
                  CareViewHorizontal(); // افترض أن "personalCare" هي قائمة المنتجات الخاصة
                } else {
                  // عندما تكون الفئة "All"
                  // افترض أن "allProducts" هي قائمة المنتجات العامة
                }

                return Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: pharmacy.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const LoedingIndecator(),
                          errorWidget: (_, __, ___) => Image.asset(
                              "assets/images/careCapsule.png",
                              height: 200),
                        ),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 30),
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
                                color: AppColors.iconColor,
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
                              SizedBox(width: screenWidth * 0.01),
                              const CustomIconCamera(),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
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
                        // عرض الويدجت الخاص بالفئة المختارة
                        selectedCategory == 'Personal Care'
                            ? CareViewHorizontal() // عرض CareViewHorizontal إذا كانت الفئة هي "Personal Care"
                            : DrugViewHorizontal(), // عرض DrugViewHorizontal إذا كانت الفئة هي "Drugs"
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
