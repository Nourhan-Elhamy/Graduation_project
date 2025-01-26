import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/controller/pharmacy_cubit.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/data/repos/pharmacy_implementation_repo.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/pharmaci_list_view.dart';
import 'package:graduation_project/shared_widgets/LocationDisplayWidget.dart';
import 'package:graduation_project/shared_widgets/container_search.dart';
import 'package:graduation_project/shared_widgets/custom_icon_filter.dart';
import 'package:graduation_project/shared_widgets/navegaitor_row.dart';

class PharmacieCategori extends StatelessWidget {
  const PharmacieCategori({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PharmacyCubit(pharmacyRepo: PharmacyRepoImplementationFromApi())..fetchPharmacies(),
      child:  Padding(
        padding: const EdgeInsets.only(left:6, right: 8, top: 25),
        child: ListView(

          children: [
            const Row(
              children: [
                Expanded(child: LocationDisplayWidget()),
                Spacer(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Pharmacies",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Expanded(child: ContainerSearch()),
                CustomIconFilter(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            NavegaitorRow(),
            BlocBuilder<PharmacyCubit, PharmacyState>(

              builder: (context, state) {
                if (state is PharmacyLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PharmacyError) {
                  return Center(child: Text(state.message));
                } else if (state is PharmacyLoaded) {
                  return PharmaciListView(pharmacyy: state.pharmacies);
                } else {
                  return Center(child: Text("No data"));
                }
              },
            ),


          ],
        ),

      ),
    );
  }
}
