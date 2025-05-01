import 'package:flutter/cupertino.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/pharmacy_list.dart';

import 'data/models/pharmacies_model.dart';

class PharmaciListView extends StatelessWidget {
  const PharmaciListView({super.key, required this.pharmacyy});
  final List<Pharmacy> pharmacyy;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: pharmacyy.length,
      itemBuilder: (_, int index) {
        return PharmacyList(pharmacy: pharmacyy[index]);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
