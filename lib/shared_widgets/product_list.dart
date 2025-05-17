import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/LoadingIndecator.dart';

class ProductList extends StatelessWidget {
  final IconData icon;
  final String image;
  final String name;
  final String egp;
  final String price;
  final VoidCallback? onTap;

  const ProductList(
      {super.key,
      required this.icon,
      required this.image,
      required this.name,
      required this.egp,
      required this.price,
        this.onTap,

      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  imageUrl: image,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const LoedingIndecator(),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.image_not_supported_outlined),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  icon,
                  size: 24,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 1),
          SizedBox(
            height: 20,
            width: 100,
            child: Text(
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              name,
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
                  text: "$egp: ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, color: Colors.black),
                ),
                TextSpan(
                  text: price,
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
  }
}
