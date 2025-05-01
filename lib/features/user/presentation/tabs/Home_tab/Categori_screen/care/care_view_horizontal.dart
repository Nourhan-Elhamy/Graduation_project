// drug_view_horizontal.dart
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/data/models/care/care/datum.dart';

import 'package:graduation_project/shared_widgets/product_list.dart';

import 'package:dio/dio.dart';

class CareViewHorizontal extends StatelessWidget {
  const CareViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Catum>>(
      future: ApiService(Dio()).getCare(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('  There are no medications'));
        }

        final List<Catum> care = snapshot.data!;

        return SizedBox(
          height: 210,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: care.length,
            itemBuilder: (context, index) {
              final medicine = care[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductList(
                  icon: Icons.add,
                  image: medicine.image ?? '',
                  name: medicine.name ?? '',
                  egp: "EGP",
                  price: medicine.price.toString(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
