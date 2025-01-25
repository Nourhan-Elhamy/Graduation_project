import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/data/models/pharmacies_model.dart';

class ProductPharmacyViewHorizontal extends StatelessWidget {
  final List<dynamic> products;

  const ProductPharmacyViewHorizontal({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: product.imageURL,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const CircularProgressIndicator(),
                        errorWidget: (_, __, ___) =>
                        const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: Text(
                    product.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Egp: ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16, color: Colors.black),
                      ),
                      TextSpan(
                        text: product.price.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

