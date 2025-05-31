import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/pharmacies_details.dart';

import '../../../../../../shared_widgets/LoadingIndecator.dart';
import 'data/models/pharmacies_model.dart';

class PharmacyList extends StatelessWidget {
  const PharmacyList({super.key, required this.pharmacy});
  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) {
          return PharmaciesDetails(
            pharmacyId: pharmacy.id,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blue,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: pharmacy.image,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const LoedingIndecator(),
                errorWidget: (_, __, ___) =>
                    Image.asset("assets/images/careCapsule.png"),
              ),
            ),
            Divider(
              color: AppColors.blue,
              thickness: 2,
              height: 0,
            ),
             SizedBox(
              height: 10.h,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 8.w, right: 8.w),
              child: Text(
                pharmacy.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 8.w, right: 8.w),
              child: Text(
                pharmacy.address,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 8.w, right: 8.w),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Email: ", // الجزء الأول
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.sp, color: Colors.black), // لون مخصص
                      ),
                      TextSpan(
                        text: pharmacy.email,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.black), // لون مخصص
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Phone: ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.sp, color: Colors.black), // لون مخصص
                      ),
                      TextSpan(
                        text: pharmacy.phone,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.black), // لون مخصص
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
