// drug_view_horizontal.dart
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';

import 'package:graduation_project/features/user/data/models/medicine/medicine/datum.dart';
import 'package:graduation_project/shared_widgets/product_list.dart';

import 'package:dio/dio.dart';

import '../product_details/presentation/product_details_screen.dart';

class DrugViewHorizontal extends StatelessWidget {
  const DrugViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum>>(
      future: ApiService(Dio()).getMedicines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          debugPrint('Snapshot Error: ${snapshot.error}');
          return Center(child: Text('error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('  There are no medications'));
        }

        final List<Datum> medicines = snapshot.data!;

        return SizedBox(
          height: 210,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductList(
                  icon: Icons.add,
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}
