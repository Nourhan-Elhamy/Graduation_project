import 'package:flutter/material.dart';
import 'pharmacy_list.dart';

class PharmaciListView extends StatelessWidget {
  const PharmaciListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (_, int index) {
        return const PharmacyList();
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
