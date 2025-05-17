import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';

import 'package:graduation_project/features/user/data/models/medicine/medicine/datum.dart';
import 'package:graduation_project/shared_widgets/product_list.dart';

import 'package:dio/dio.dart';

import '../product_details/presentation/product_details_screen.dart';

class DrugViewGrid extends StatelessWidget {
  const DrugViewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum>>(
      future: ApiService(Dio()).getMedicines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('There are no medications  '));
        }

        final List<Datum> medicines = snapshot.data!;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.1,
            mainAxisSpacing: 5,
          ),
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            final medicine = medicines[index];
            return ProductList(
              icon: Icons.favorite_border_outlined,
              image: medicine.image ?? '',
              name: medicine.name ?? '',
              egp: "EGP",
              price: medicine.price.toString(),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(productId: medicine.id!),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
