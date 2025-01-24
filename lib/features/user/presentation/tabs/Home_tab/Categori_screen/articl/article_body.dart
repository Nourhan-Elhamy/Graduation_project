import 'package:flutter/material.dart';

class ArticleBody extends StatelessWidget {
  const ArticleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brain Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Breast Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Endocrine Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Gastrointestinal Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Genitourinary Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Gynecologic Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Head and Neck Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Hematologic Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Lung Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Skin Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          Text(
            'Soft Tissue and Bone Cancer',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
