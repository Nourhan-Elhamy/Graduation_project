import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';


class ProductList extends StatefulWidget {
  final IconData icon;
  final Function(String)? onFavoriteToggle; // دالة للتعامل مع المفضلة

  const ProductList({super.key, required this.icon, this.onFavoriteToggle});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false; // بداية المفضلة تكون غير مفعلة
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // تغيير حالة المفضلة عند الضغط
    });

    if (widget.onFavoriteToggle != null) {
      widget.onFavoriteToggle!(isFavorite ? "added" : "removed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: 'https://www.iisertvm.ac.in/assets/images/placeholder.jpg',
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
                onTap: toggleFavorite,
                child: Icon(
                  isFavorite ? Icons.favorite : widget.icon,
                  size: 24,
                  color: isFavorite ? AppColors.blue : AppColors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 1),
        SizedBox(
          height: 20,
          width: 100,
          child: Text(
            'Antinal 200 mg - 24 Capsules',
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
                text: "60",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}