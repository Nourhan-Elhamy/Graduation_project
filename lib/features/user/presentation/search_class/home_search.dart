import 'package:flutter/material.dart';

import '../../../../shared_widgets/custom_text_filde.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomTextFilde(hintText: "Search", icon: Icons.search,),
    );
  }
}