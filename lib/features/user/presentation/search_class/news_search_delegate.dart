import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/medicine_search.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/pharmacy_search.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/product_details/presentation/product_details_screen.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/pharmacies_details.dart';

import '../../../../core/utils/app_colors.dart';


class NewsSearchDelegate extends SearchDelegate {
  final ApiService apiService;

  NewsSearchDelegate({required this.apiService});

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.search(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('error ${snapshot.error}'));
        }

        final pharmacies = snapshot.data!['pharmacies'] as List<PharmacySearch>;

        final medicines = snapshot.data!['medicines'] as List<MedicineSearch>;
        if (pharmacies.isEmpty && medicines.isEmpty) {
          return Center(child: Text('No results found.'));
        }
        return ListView(
          children: [
            if (medicines.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Text('Products', style: TextStyle(fontSize: 20.sp,color: AppColors.grey)),
              ),
            ...medicines.map((medicine) => ListTile(
              leading: SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: Image.network(medicine.image ?? '', width: 60.w)),
              title: Text(medicine.name ?? '',style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsScreen(productId: medicine.id ?? ""),
                  ),
                );
              },
            )),
            if (pharmacies.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Text('Pharmacies', style: TextStyle(fontSize: 20.sp,color: AppColors.grey)),
              ),
            ...pharmacies.map((pharmacy) => ListTile(
              leading: SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: Image.network(pharmacy.image ?? '', width: 50.w)),
              title: Text(pharmacy.name ?? '',style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PharmaciesDetails(
                      pharmacyId: pharmacy.id ?? '',
                    ),
                  ),
                );
              },
            )),

          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Search For Product'));
    }
    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.search(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('error happen ${snapshot.error}'));
        }

        final pharmacies = snapshot.data!['pharmacies'] as List<PharmacySearch>;
        final medicines = snapshot.data!['medicines'] as List<MedicineSearch>;

        if (pharmacies.isEmpty && medicines.isEmpty) {
          return Center(child: Text('Items not found'));
        }

        return ListView(
          children: [
            if (medicines.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Text('Products', style: TextStyle(fontSize: 20.sp,color: AppColors.grey)),
              ),
            ...medicines.map((medicine) => ListTile(
              leading: SizedBox(
                width: 50.w,
                height: 50.h,
                child: Image.network(medicine.image ?? ''),
              ),
              title: Text(medicine.name ?? '',style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsScreen(productId: medicine.id ?? ''),
                  ),
                );
              },
            )),
            if (pharmacies.isNotEmpty)
              Padding(
                padding:  EdgeInsets.all(8.r),
                child: Text('Pharmacies', style: TextStyle(fontSize: 20.sp,color: AppColors.grey)),
              ),
            ...pharmacies.map((pharmacy) => ListTile(
              leading: SizedBox(
                width: 50.w,
                height: 50.h,
                child: Image.network(pharmacy.image ?? ''),
              ),
              title: Text(pharmacy.name ?? '',style: TextStyle(color: AppColors.grey,fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PharmaciesDetails(
                      pharmacyId: pharmacy.id ?? '',
                    ),
                  ),
                );
              },
            )),
          ],
        );
      },
    );
  }

}
