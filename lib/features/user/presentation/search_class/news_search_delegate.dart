import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/medicine_search.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/pharmacy_search.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/product_details/presentation/product_details_screen.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/pharmacies_details.dart';

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
            if (pharmacies.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Pharmacies', style: TextStyle(fontSize: 18)),
              ),
            ...pharmacies.map((pharmacy) => ListTile(
                  leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(pharmacy.image ?? '', width: 50)),
                  title: Text(pharmacy.name ?? ''),
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
            if (medicines.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Products', style: TextStyle(fontSize: 18)),
              ),
            ...medicines.map((medicine) => ListTile(
                  leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(medicine.image ?? '', width: 50)),
                  title: Text(medicine.name ?? ''),
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
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // أو نفس buildResults لو حبيت
  }
}
