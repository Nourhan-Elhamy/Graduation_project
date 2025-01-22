import 'package:flutter/material.dart';

class NavegaitorRow extends StatelessWidget {
  const NavegaitorRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              "assets/images/Pharmacy select.png",
            ),
          ),
          Text(
            "Pharmacies Near You",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // const Spacer(),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const PharmacieCategori(),
          //       ),
          //     );
          //   },
          //   child: Text(
          //     "View All",
          //     style: TextStyle(
          //       fontSize: 15,
          //       color: AppColors.blue,
          //       decoration: TextDecoration.underline,
          //       decorationColor: AppColors.blue,
          //       decorationThickness: 2.0,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
