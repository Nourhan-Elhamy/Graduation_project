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
      create: (context) =>
          PharmacyCubit(pharmacyRepo: PharmacyRepoImplementationFromApi())
            ..fetchPharmacies(),
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 8, top: 25),
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
            // استخدام الويدجت المعدلة
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
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        if (state is PharmacyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PharmacyError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PharmacyCubit>().fetchPharmacies();
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is PharmacyLoaded) {
          if (state.pharmacies.isEmpty) {
            return const Center(
              child: Text(
                'No pharmacies available',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          final pharmaciesToShow = state.pharmacies.skip(startIndex).take(numToShow).toList();
          return PharmaciListView(pharmacyy: pharmaciesToShow);
        } else {
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(fontSize: 16),
            ),
          );
        }
      },
    );
  }
}
